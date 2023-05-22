provider "aws" {
  region = "us-east-1"
}


module "context" {
  source = "../../../modules/context"
}


module "cloudfront" {
  source                           = "../../../modules/client/cloudfront"
  aliases                          = ["aliases_client"]
  dns_alias_enabled                = true
  parent_zone_id                   = "parent_zone_id"
  acm_certificate_arn              = ""
  s3_bucket_access_log_bucket_name = "s3_bucket_access_log_bucket_name"
  context                          = module.context
}

