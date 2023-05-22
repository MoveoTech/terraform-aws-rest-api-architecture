
module "context" {
  source = "../../../modules/context"
}


# API Gateway and VPC link
module "api_gateway" {
  source                              = "../../../modules/backend/api-gateway"
  domain_name                         = "domain_name"
  cors_domain                         = ["cors_domain"]
  zone_id                             = "zone_id"
  acm_request_certificate_arn         = "certicficate"
  kms_key_arn                         = "kms arn"
  integration_input_type              = "HTTP_PROXY"
  path_part                           = "{proxy+}"
  nlb_arn                             = "nlb arn"
  elastic_beanstalk_environment_cname = "envoironment"
  elastic_beanstalk_application_name  = "apllication name"
  user_pool_arn                       = "user_pool_arn"
  cognito_enabled                     = true
  context                             = module.context
}
