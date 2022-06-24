data "aws_caller_identity" "current" {}
resource "random_string" "random" {
  length  = 5
  special = false
}

module "s3_bucket" {
  source              = "cloudposse/s3-bucket/aws"
  version             = "2.0.2"
  block_public_policy = true
  acl                 = "private"
  force_destroy       = true
  user_enabled        = false
  versioning_enabled  = true
  bucket_key_enabled  = true
  bucket_name         = var.bucket_name
  context             = var.context
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
          UserParameters = "${var.cf_distribution_id}"
        }
      }
    }
  }
}
