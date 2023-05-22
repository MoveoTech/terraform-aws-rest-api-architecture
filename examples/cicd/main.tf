provider "aws" {
  region = "us-east-1"
}


module "context" {
  source = "../../modules/context"
}



module "cicd" {
  source                           = "../../modules/cicd"
  github_org                       = "github_org"
  client_env_prefix                = "client_env_prefix"
  s3_bucket_access_log_bucket_name = "s3_bucket_access_log_bucket_name"
  region                           = "us-east-1"
  client_repository_name           = "client_repository_name"
  client_branch_name               = "client_branch_name"
  server_repository_name           = "server_repository_name"
  server_branch_name               = "server_branch_name"

  client_buildspec_path = "client_buildspec_path"
  server_buildspec_path = "server_buildspec_path"

  elastic_beanstalk_application_name = "elastic_beanstalk_application_name"
  elastic_beanstalk_environment_name = "elastic_beanstalk_environment_name"
  client_bucket_name                 = "client_bucket_name"
  cognito_pool_id                    = "cognito_pool_id"
  cognito_web_client_id              = "cognito_web_client_id"
  cf_distribution_id                 = "cf_distribution_id"
  invoke_url                         = "invoke_url"
  private_subnet_ids                 = ["private_subnet_ids"]
  vpc_id                             = "vpc_id"


  codebuild_client_env_vars = null
  context                   = module.context
}
