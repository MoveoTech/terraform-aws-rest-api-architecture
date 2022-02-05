
provider "aws" {
  region = var.region
}

module "network" {
  source             = "./network"
  region             = var.region
  availability_zones = var.availability_zones
  context            = module.this.context
}

module "server" {
  source = "./backend"

  region                  = var.region
  app_name                = var.app_name
  availability_zones      = var.availability_zones
  instance_type           = var.instance_type
  solution_stack_name     = var.solution_stack_name
  vpc_id                  = module.network.vpc_id
  app_port                = var.app_port
  private_subnet_ids      = module.network.private_subnet_ids
  private_route_table_ids = module.network.private_route_table_ids
  platform_name           = var.platform_name

  depends_on = [module.network]
  context    = module.this.context
}



# module "acm_request_certificate" {
#   source                    = "./client/acm"
#   domain_name               = var.domain_name
#   zone_id                   = var.parent_zone_id
#   subject_alternative_names = var.subject_alternative_names
# }


module "cloudfront_s3_cdn" {
  source              = "./client/cloudfront"
  region              = var.region
  aliases             = var.aliases
  dns_alias_enabled   = var.dns_alias_enabled
  parent_zone_id      = var.parent_zone_id
  # acm_certificate_arn = module.acm_request_certificate.acm_request_certificate_arn
  # depends_on          = [module.acm_request_certificate]
  context             = module.this.context
}


