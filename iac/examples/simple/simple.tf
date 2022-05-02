
module "infrastructure" {
  source  = "MoveoTech/api-aws/rest"
  version = "0.0.2"

  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "eliran@moveohls.com"
  client_repository_name     = "terraform-rest-api-aws"
  client_branch_name         = "main"
  server_repository_name     = "terraform-rest-api-aws"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
  module                     = var.module
}
