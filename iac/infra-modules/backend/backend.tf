module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}
module "kms" {
  source     = "../kms"
  region     = var.region
  alias_name = "eb-backend-${module.label.stage}"
  context    = var.context
}

module "elastic_beanstalk" {
  source                        = "./elastic-beanstalk"
  region                        = var.region
  ssm_arn                       = var.ssm_arn
  availability_zones            = var.availability_zones
  instance_type                 = var.instance_type
  vpc_id                        = var.vpc_id
  private_subnet_ids            = var.private_subnet_ids
  associated_security_group_ids = var.associated_security_group_ids
  context                       = var.context
}

module "waf_api_gateway" {
  source                    = "../waf"
  association_resource_arns = [module.api_gateway.arn]
  type                      = "cloudfront"
  kms_key_arn = module.kms.key_arn
  context     = var.context
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
  elastic_beanstalk_application_name  = module.label.name
  depends_on                          = [module.elastic_beanstalk.elastic_beanstalk_application]
  user_pool_arn                       = var.user_pool_arn
  context                             = var.context
}
