
module "kms" {
  source     = "../kms"
  region     = var.region
  alias_name = "eb-backend-${var.context.stage}"
  context    = var.context
}

module "elastic_beanstalk" {
  source                           = "./elastic-beanstalk"
  region                           = var.region
  instance_type                    = var.instance_type
  vpc_id                           = var.vpc_id
  private_subnet_ids               = var.private_subnet_ids
  associated_security_group_ids    = var.associated_security_group_ids
  autoscale_max                    = var.autoscale_max
  autoscale_min                    = var.autoscale_min
  s3_bucket_access_log_bucket_name = var.s3_bucket_access_log_bucket_name
  env_vars                         = var.env_vars
  extended_ec2_policy_document     = var.extended_ec2_policy_document
  context                          = var.context
}

module "waf_api_gateway" {
  source                    = "../waf"
  association_resource_arns = [module.api_gateway.arn]
  type                      = "cloudfront"
  kms_key_arn               = module.kms.key_arn
  context                   = var.context
}

# API Gateway and VPC link
module "api_gateway" {
  source                              = "./api-gateway"
  domain_name                         = var.domain_name
  cors_domain                         = var.cors_domain
  zone_id                             = var.zone_id
  acm_request_certificate_arn         = var.acm_request_certificate_arn
  kms_key_arn                         = module.kms.key_arn
  integration_input_type              = "HTTP_PROXY"
  path_part                           = "{proxy+}"
  nlb_arn                             = module.elastic_beanstalk.load_balancers_arn
  elastic_beanstalk_environment_cname = module.elastic_beanstalk.load_balancers_arn
  elastic_beanstalk_application_name  = var.context.name
  depends_on                          = [module.elastic_beanstalk.elastic_beanstalk_application]
  user_pool_arn                       = var.user_pool_arn
  cognito_enabled                     = var.cognito_enabled
  context                             = var.context
}
