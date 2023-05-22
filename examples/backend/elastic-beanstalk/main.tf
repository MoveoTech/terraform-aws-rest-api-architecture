provider "aws" {
  region = "us-east-1"
}


module "context" {
  source = "../../../modules/context"
}


module "elastic_beanstalk" {
  source                           = "../../../modules/backend/elastic-beanstalk"
  region                           = "us-east-1"
  vpc_id                           = "vpc_id"
  private_subnet_ids               = ["private_subnet_id"]
  associated_security_group_ids    = "security_group"
  autoscale_max                    = 2
  autoscale_min                    = 1
  s3_bucket_access_log_bucket_name = "s3_bucket_name"
  env_vars = {
    NODE_ENV = "develop"
  }
  context = module.context
}
