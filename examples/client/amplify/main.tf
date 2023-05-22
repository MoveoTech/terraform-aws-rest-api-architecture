provider "aws" {
  region = "us-east-1"
}


module "amplify" {
  source                      = "../../../modules/client/amplify"
  name                        = "name"
  client_repository_name      = "client_repository_name"
  enable_auto_branch_creation = true
  branch                      = "branch"
}

