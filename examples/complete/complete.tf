
module "infrastructure" {
  source  = "MoveoTech/api-aws/rest"
  version = "0.0.2"

  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  instance_type              = "t3.micro"
  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "dev@moveohls.com"
  client_repository_name     = "terraform-rest-api-aws"
  client_branch_name         = "main"
  server_repository_name     = "terraform-rest-api-aws"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
  module                     = var.module

  atlas_users                = ["dev@moveohls.com"]
  private_endpoint_enabled   = true
  enable_atlas_whitelist_ips = false
  atlas_whitelist_ips        = []

  client_logout_urls          = ["https://www.test.terraform.moveodevelop.com/logout"]
  client_default_redirect_uri = "https://www.test.terraform.moveodevelop.com"
  client_callback_urls        = ["https://www.test.terraform.moveodevelop.com"]


  parent_zone_id            = "ZZG2X8KI3MIQB"
  aliases_client            = ["test.terraform.moveodevelop.com", "www.test.terraform.moveodevelop.com"]
  domain_name               = "test.terraform.moveodevelop.com"
  subject_alternative_names = ["www.test.terraform.moveodevelop.com"]
  dns_alias_enabled         = true
}
