module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}
resource "random_string" "random" {
  length  = 5
  special = false
}
resource "aws_codebuild_project" "main" {
  name          = "${module.label.name}-${module.label.stage}-${random_string.random.result}"
  service_role  = aws_iam_role.main.arn
  build_timeout = "10"

  artifacts {
    type = "CODEPIPELINE"
  }

  # encryption_key = var.kms_arn
  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = var.image
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "STAGE_NAME"
      value = module.label.stage
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }
}
