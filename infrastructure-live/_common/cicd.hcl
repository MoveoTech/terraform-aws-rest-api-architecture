# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for mysql. The common variables for each environment to
# deploy mysql are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  source = "${local.base_source_url}?ref=v${local.version_number}"
}


# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  versions_vars = read_terragrunt_config(find_in_parent_folders("versions.hcl"))

  github_org = local.account_vars.locals.github_org

  client_env_prefix = local.account_vars.locals.client_env_prefix

  client_repository_name = local.account_vars.locals.client_repository_name
  server_repository_name = local.account_vars.locals.server_repository_name

  client_buildspec_path = local.account_vars.locals.client_buildspec_path
  server_buildspec_path = local.account_vars.locals.server_buildspec_path

  version_number = local.versions_vars.locals.base_architecture_version

  server_branch_name = local.environment_vars.locals.server_branch_name
  client_branch_name = local.environment_vars.locals.client_branch_name
  region = local.environment_vars.locals.region

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  base_source_url = "git::git@github.com:MoveoTech/terraform-aws-rest-api-architecture.git//modules/cicd"
}


dependencies {
  paths = [
    "../access-log-bucket", "../context","../network",
    "../server/api-gateway","../client/cloudfront","../cognito",
    "../server/elastic-beanstalk"
    ]
}

dependency "elastic_beanstalk"{
     config_path   = "../server/elastic-beanstalk"
}

dependency "client"{
     config_path   = "../client/cloudfront"
}

dependency "cognito"{
     config_path   = "../cognito"
}

dependency "api_gateway" {
  config_path   = "../server/api-gateway"
}

dependency "access_log_bucket"{
  config_path="../access-log-bucket"
}

dependency "context" {
  config_path   = "../context"
}

dependency "network" {
  config_path   = "../network"
}

inputs={
  github_org                         = local.github_org
  client_env_prefix                  = local.client_env_prefix
  client_repository_name             = local.client_repository_name
  client_branch_name                 = local.client_branch_name
  client_buildspec_path              = local.client_buildspec_path
  server_buildspec_path              = local.server_buildspec_path
  server_repository_name             = local.server_repository_name
  server_branch_name                 = local.server_branch_name  
  elastic_beanstalk_application_name = dependency.elastic_beanstalk.outputs.elastic_beanstalk_application_name
  elastic_beanstalk_environment_name = dependency.elastic_beanstalk.outputs.elastic_beanstalk_environment_name

  cognito_pool_id                    = dependency.cognito.outputs.user_pool_id
  cognito_web_client_id              = dependency.cognito.outputs.web_client_id
  client_bucket_name                 = dependency.client.outputs.s3_bucket
  cf_distribution_id                 = dependency.client.outputs.cf_id
  invoke_url                         = dependency.api_gateway.outputs.invoke_url
  private_subnet_ids                 = dependency.network.outputs.private_subnet_ids
  vpc_id                             = dependency.network.outputs.vpc_id
  region                             = local.region
  s3_bucket_access_log_bucket_name   = dependency.access_log_bucket.outputs.bucket_id
  context                            = dependency.context.outputs.context
}
