
# GitHub secrets
data "aws_secretsmanager_secret" "github_secret" {
  name = var.github_secret_name
}

data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = data.aws_secretsmanager_secret.github_secret.id
}

module "kms" {
  source     = "../kms"
  alias_name = "codepipline-${var.context.stage}"
  region     = var.region
  context    = var.context
}

module "security_group" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  # Security Group names must be unique within a VPC.
  # This module follows Cloud Posse naming conventions and generates the name
  # based on the inputs to the null-label module, which means you cannot
  # reuse the label as-is for more than one security group in the VPC.
  #
  # Here we add an attribute to give the security group a unique name.
  attributes = ["cicd-${var.context.stage}"]

  # Allow unlimited egress
  allow_all_egress = true
  vpc_id           = var.vpc_id

  context = var.context
}



# Codebuild module for CI
module "codebuild_application_server" {
  source             = "./codebuild"
  name               = "${var.context.stage}-${var.context.name}-server-build"
  image              = "aws/codebuild/standard:4.0"
  buildspec_path     = "server/buildspec.yml"
  kms_arn            = module.kms.key_arn
  security_group_id  = module.security_group.id
  private_subnet_ids = var.private_subnet_ids
  vpc_id             = var.vpc_id

  context = var.context
}

# CodePipeline module for CICD pipeline
module "codepipeline_server_app" {
  source          = "./codepipeline"
  name            = "${var.context.stage}-${var.context.name}-server-pipline"
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.server_repository_name
  branch_name     = var.server_branch_name
  project_name    = module.codebuild_application_server.project_name
  bucket_name     = "${var.context.stage}-${var.context.name}-server-pipline"
  configuration = {
    ApplicationName = var.elastic_beanstalk_application_name
    EnvironmentName = var.elastic_beanstalk_environment_name
  }
  deploy_provider = "ElasticBeanstalk"
  github_token    = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context         = var.context
}

# Codebuild module for CI
module "codebuild_application_client" {
  source             = "./codebuild"
  name               = "${var.context.stage}-${var.context.name}-client-build"
  image              = "aws/codebuild/standard:4.0"
  security_group_id  = module.security_group.id
  private_subnet_ids = var.private_subnet_ids
  vpc_id             = var.vpc_id
  environment_variables = [{
    name  = "REACT_APP_AWS_REGION"
    value = var.region
    type  = "PLAINTEXT"
    },
    {
      name  = "REACT_APP_AWS_POOL_ID"
      value = var.cognito_pool_id
      type  = "PLAINTEXT"
    },
    {
      name  = "REACT_APP_AWS_WEB_CLIENT_ID"
      value = var.cognito_web_client_id
      type  = "PLAINTEXT"

    },
    {
      name  = "REACT_APP_API_BASE_URL"
      value = var.invoke_url
      type  = "PLAINTEXT"

  }]
  kms_arn        = module.kms.key_arn
  buildspec_path = "client/buildspec.yml"
  context        = var.context

}

# CodePipeline module for CICD pipeline
module "codepipeline_client_app" {
  source          = "./codepipeline"
  name            = "${var.context.stage}-${var.context.name}-client-pipeline"
  kms_arn         = module.kms.key_arn
  github_org      = var.github_org
  repository_name = var.client_repository_name
  branch_name     = var.client_branch_name
  bucket_name     = "${var.context.stage}-${var.context.name}-client-pipeline"
  project_name    = module.codebuild_application_client.project_name
  deploy_provider = "S3"
  configuration = {
    BucketName = var.client_bucket_name
    Extract    = true
  }

  lambda_name        = module.cloudfront_invalidation.function_name
  cf_distribution_id = var.cf_distribution_id
  github_token       = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
  context            = var.context
}

module "cloudfront_invalidation" {
  source             = "./cloudfron-auto-invalidator"
  name               = "cloudfront-invalidation-${var.context.stage}"
  private_subnet_ids = var.private_subnet_ids
  security_group_id  = module.security_group.id

  context = var.context
}
