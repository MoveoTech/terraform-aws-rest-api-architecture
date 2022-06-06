
module "infrastructure" {
  source = "../../"

  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  stage                      = "develop"
  name                       = "terraform-moveohls"
  cognito_default_user_email = "eliran@moveohls.com"
  client_repository_name     = "terraform-aws-rest-api-architecture"
  client_branch_name         = "main"
  server_repository_name     = "terraform-aws-rest-api-architecture"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  private_endpoint_enabled   = false
  enable_atlas_whitelist_ips = true
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
}



resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = module.infrastructure.atlas_project_id
  ip_address = "93.157.85.78"
  comment    = "Example ip address for accessing the cluster"
}