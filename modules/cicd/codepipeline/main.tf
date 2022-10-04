data "aws_caller_identity" "current" {}
resource "random_string" "random" {
  length  = 5
  special = false
}

module "s3_bucket" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.27.0"

  name                     = var.bucket_name
  block_public_policy      = true
  allow_ssl_requests_only  = true
  versioning_enabled       = true
  acl                      = "private"
  sse_algorithm            = "aws:kms"
  access_log_bucket_prefix = "/pipline-logs"
  access_log_bucket_name   = var.s3_bucket_access_log_bucket_name

  context = var.context
}
resource "aws_codepipeline" "main" {
  name     = var.name
  role_arn = aws_iam_role.main.arn

  artifact_store {
    location = module.s3_bucket.bucket_id
    type     = "S3"
    encryption_key {
      id   = var.kms_arn
      type = "KMS"
    }
  }


  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        Owner                = var.github_org
        Repo                 = var.repository_name
        PollForSourceChanges = "false"
        Branch               = var.branch_name
        OAuthToken           = var.github_token

      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName   = var.project_name
        PrimarySource = "SourceArtifact"
      }
      run_order = 2
    }
  }


  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = var.deploy_provider
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = var.configuration
      run_order     = 3
    }
  }

  dynamic "stage" {
    for_each = var.cf_distribution_id != null ? ["true"] : []
    content {
      name = "cloudfront-revalidation"

      action {
        name            = "cloudfront-revalidation"
        category        = "Invoke"
        owner           = "AWS"
        provider        = "Lambda"
        input_artifacts = []
        version         = "1"

        configuration = {
          FunctionName   = var.lambda_name
          UserParameters = var.cf_distribution_id
        }
      }
    }
  }
}
