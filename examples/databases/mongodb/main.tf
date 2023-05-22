module "context" {
  source = "../../../modules/context"
}


module "atlas_database" {
  source                      = "../../../modules/database"
  region                      = "region"
  atlas_org_id                = "atlas_org_id"
  vpc_id                      = "vpc_id"
  cidr_block                  = "vpc_cidr_block"
  private_subnet_ids          = ["private_subnet_ids"]
  atlas_whitelist_ips         = ["nat_gateway_public_ips"]
  private_endpoint_enabled    = true
  atlas_users                 = ["atlas_users"]
  provider_instance_size_name = "provider_instance_size_name"
  enable_atlas_whitelist_ips  = true
  public_key                  = "public_key"
  private_key                 = "private_key"
  context                     = module.context
}

