
resource "random_string" "random" {
  length  = 5
  special = false
}
resource "aws_codebuild_project" "main" {
  name          = var.name
  service_role  = aws_iam_role.main.arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }
  vpc_config {
    vpc_id = var.vpc_id

    subnets            = var.private_subnet_ids
    security_group_ids = [var.security_group_id]
  }

  encryption_key = var.kms_arn
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "STAGE_NAME"
      value = var.context.stage
    }
    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec_path
  }
}
