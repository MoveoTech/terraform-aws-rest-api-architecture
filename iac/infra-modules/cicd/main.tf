


# GitHub secrets
data "aws_secretsmanager_secret" "github_secret" {
  name = var.github_secret_name
}

data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = data.aws_secretsmanager_secret.github_secret.id
}

module "kms" {
  source     = "../kms"
  alias_name = "codepipline"
  service_name = [
    "codepipeline.amazonaws.com",
    "s3.amazonaws.com",
  ]
  context = module.this.context
}


# Codebuild module for CI
module "codebuild_application" {
  source      = "./codebuild"
  name        = "codebuild-app"
  image       = "aws/codebuild/standard:4.0"
  environment = var.environment
  context     = module.this.context
}

# CodePipeline module for CICD pipeline
module "codepipeline_app" {
  source                             = "./codepipeline"
  name                               = "codepipeline-app"
  kms_arn                            = module.kms.key_arn
  bucket_name                        = var.bucket_name
  github_org                         = var.github_org
  repository_name                    = var.repository_name
  branch_name                        = var.branch_name
  environment                        = var.environment
  region                             = var.region
  project_name                       = module.codebuild_application.project_name
  elastic_beanstalk_application_name = var.elastic_beanstalk_application_name
  elastic_beanstalk_environment_name = var.elastic_beanstalk_environment_name
  github_token                       = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context                            = module.this.context
}

