
locals {
  codebuild_name    = var.codebuild_name ? var.codebuild_name : "build-app-${var.pipline_type}"
  codepipeline_name = var.codebuild_name ? var.codebuild_name : "pipline-app-${var.pipline_type}"
}

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
module "codebuild_application_server" {
  source         = "./codebuild"
  name           = "codebuild_server"
  image          = "aws/codebuild/standard:4.0"
  buildspec_path = "server/buildspec.yml"
  environment    = var.environment
  context        = module.this.context
}

# CodePipeline module for CICD pipeline
module "codepipeline_server_app" {
  source          = "./codepipeline"
  name            = local.codepipeline_name
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.server_repository_name
  branch_name     = var.server_branch_name
  environment     = var.environment
  region          = var.region
  project_name    = module.codebuild_application_server.project_name
  configuration = {
    ApplicationName = var.elastic_beanstalk_application_name
    EnvironmentName = var.elastic_beanstalk_environment_name
  }
  github_token = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context      = module.this.context
}

# Codebuild module for CI
module "codebuild_application_client" {
  source         = "./codebuild"
  name           = "codebuild_client"
  image          = "aws/codebuild/standard:4.0"
  environment    = var.environment
  buildspec_path = "client/buildspec.yml"
  context        = module.this.context

}

# CodePipeline module for CICD pipeline
module "codepipeline_client_app" {
  source          = "./codepipeline"
  name            = local.codepipeline_name
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.client_repository_name
  branch_name     = var.client_branch_name
  environment     = var.environment
  region          = var.region
  project_name    = module.codebuild_application_client.project_name
  configuration = {
    BucketName = var.client_bucket_name
    Extract    = "true"
  }
  github_token = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context      = module.this.context
}
