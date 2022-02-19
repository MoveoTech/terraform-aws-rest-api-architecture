resource "aws_codebuild_project" "main" {
  name          = "${var.name}-${var.environment}"
  service_role  = aws_iam_role.main.arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }

  #cache {
  #  type = "S3"
  #  location = "${var.bucket_name}/${var.name}/build_cache"
  #}

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "STAGE_NAME"
      value = var.environment
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
  tags = {
    yor_trace = "4624b1a4-2283-4288-b471-f94e1c4e2f12"
  }
}
