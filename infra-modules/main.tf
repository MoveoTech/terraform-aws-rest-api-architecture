provider "aws" {
  region = var.region
}

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}


module "network" {
  source             = "./network"
  region             = var.region
  availability_zones = var.availability_zones
  context            = module.this.context
}

module "atlas_database" {
  source             = "./database"
  region             = var.region
  public_key         = var.public_key
  private_key        = var.private_key
  atlas_org_id       = var.atlas_org_id
  vpc_id             = module.network.vpc_id
  cidr_block         = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids
  atlas_users        = var.atlas_users
  context            = module.this.context
}

module "server" {
  source = "./backend"

  region                        = var.region
  app_name                      = var.app_name
  availability_zones            = var.availability_zones
  instance_type                 = var.instance_type
  vpc_id                        = module.network.vpc_id
  app_port                      = var.app_port
  private_subnet_ids            = module.network.private_subnet_ids
  private_route_table_ids       = module.network.private_route_table_ids
  associated_security_group_ids = module.atlas_database.atlas_resource_sg_id
  platform_name                 = var.platform_name
  db_connection_string          = module.atlas_database.db_connection_string
  db_username                   = module.atlas_database.db_username
  db_password                   = module.atlas_database.db_password

  depends_on = [module.network]
  context    = module.this.context
}



# module "acm_request_certificate" {
#   source                    = "./client/acm"
#   domain_name               = var.domain_name
#   zone_id                   = var.parent_zone_id
#   subject_alternative_names = var.subject_alternative_names
# }


# module "cloudfront_s3_cdn" {
#   source              = "./client/cloudfront"
#   region              = var.region
#   aliases             = var.aliases
#   dns_alias_enabled   = var.dns_alias_enabled
#   parent_zone_id      = var.parent_zone_id
#   # acm_certificate_arn = module.acm_request_certificate.acm_request_certificate_arn
#   # depends_on          = [module.acm_request_certificate]
#   context             = module.this.context
# }


