

module "kms" {
  source     = "../kms"
  alias_name = "eb_backend"
  service_name = [
    "elasticbeanstalk.amazonaws.com",
    "logs.amazonaws.com",
  ]
  context = var.context
}

module "elastic_beanstalk" {
  source                        = "./elastic-beanstalk"
  region                        = var.region
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
  kms_key_arn               = module.kms.key_arn
  context                   = var.context
}

# API Gateway and VPC link
module "api_gateway" {
  source                              = "./api-gateway"
  kms_key_arn               = module.kms.key_arn
  integration_input_type              = "HTTP_PROXY"
  path_part                           = "{proxy+}"
  app_port                            = var.app_port
  nlb_arn                             = module.elastic_beanstalk.load_balancers_arn
  elastic_beanstalk_environment_cname = module.elastic_beanstalk.load_balancers_arn
  elastic_beanstalk_application_name  = var.app_name
  depends_on                          = [module.elastic_beanstalk.elastic_beanstalk_application]
  context                             = var.context
}
