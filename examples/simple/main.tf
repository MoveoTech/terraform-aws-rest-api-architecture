
module "infrastructure" {
  source = "../../"

  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  stage                      = "develop"
  name                       = "rest-api-architecture-test"
  cognito_default_user_email = "eliran@moveohls.com"
  client_repository_name     = "terraform-aws-rest-api-architecture"
  client_branch_name         = "main"
  server_repository_name     = "terraform-aws-rest-api-architecture"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
}
