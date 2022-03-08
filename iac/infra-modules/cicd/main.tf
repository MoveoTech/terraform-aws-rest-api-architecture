module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
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
  alias_name = "codepipline-${module.label.stage}"
  region     = var.region
  service_name = [
    "codepipeline.amazonaws.com",
    "codebuild.amazonaws.com",
    "s3.amazonaws.com",
  ]
  context = module.this.context
}


# Codebuild module for CI
module "codebuild_application_server" {
  source         = "./codebuild"
  name           = "${module.label.stage}-${module.label.name}-server-build"
  image          = "aws/codebuild/standard:4.0"
  buildspec_path = "server/buildspec.yml"
  environment    = var.environment
  kms_arn        = module.kms.key_arn
  context        = module.this.context
}

# CodePipeline module for CICD pipeline
module "codepipeline_server_app" {
  source          = "./codepipeline"
  name            = "${module.label.stage}-${module.label.name}-server-pipline"
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.server_repository_name
  branch_name     = var.server_branch_name
  environment     = var.environment
  region          = var.region
  project_name    = module.codebuild_application_server.project_name
  bucket_name     = "${module.label.stage}-${module.label.name}-server-pipline"
  configuration = {
    ApplicationName = var.elastic_beanstalk_application_name
    EnvironmentName = var.elastic_beanstalk_environment_name
  }
  deploy_provider = "ElasticBeanstalk"
  github_token    = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context         = module.this.context
}

# Codebuild module for CI
module "codebuild_application_client" {
  source         = "./codebuild"
  name           = "${module.label.stage}-${module.label.name}-client-build"
  image          = "aws/codebuild/standard:4.0"
  environment    = var.environment
  kms_arn        = module.kms.key_arn
  buildspec_path = "client/buildspec.yml"
  context        = module.this.context

}

# CodePipeline module for CICD pipeline
module "codepipeline_client_app" {
  source          = "./codepipeline"
  name            = "${module.label.stage}-${module.label.name}-client-pipeline"
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.client_repository_name
  branch_name     = var.client_branch_name
  environment     = var.environment
  region          = var.region
  bucket_name     = "${module.label.stage}-${module.label.name}-client-pipeline"
  project_name    = module.codebuild_application_client.project_name
  deploy_provider = "S3"
  configuration = {
    BucketName = var.client_bucket_name
    Extract    = true
  }
  github_token = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context      = module.this.context
}
