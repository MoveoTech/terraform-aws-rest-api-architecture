
module "infrastructure" {
  source = "../"



  stage                       = var.stage
  region                      = var.region
  availability_zones          = var.availability_zones
  name                        = var.name
  cognito_default_user_email  = var.cognito_default_user_email
  client_repository_name      = var.client_repository_name
  client_branch_name          = var.client_branch_name
  server_repository_name      = var.server_repository_name
  server_branch_name          = var.server_branch_name
  github_org                  = var.github_org
  public_key                  = var.public_key
  private_key                 = var.private_key
  atlas_org_id                = var.atlas_org_id
  atlas_users                 = var.atlas_users
  enable_atlas_whitelist_ips  = var.enable_atlas_whitelist_ips
  private_endpoint_enabled    = var.private_endpoint_enabled
  provider_instance_size_name = var.provider_instance_size_name
}

