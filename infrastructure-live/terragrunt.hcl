locals {

  # Automatically load environment-level variables
  stage_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  
  # Extract the variables we need for easy access
  name = local.account_vars.locals.name
  region   = local.stage_vars.locals.region
  stage   = local.stage_vars.locals.stage
}
# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF
  provider "aws" {
    region = "${local.region}"

  }
EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "${local.name}-${local.region}-terraform-s3"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = local.region
    encrypt = true
    dynamodb_table = "terraform-app-lock-table"
  }
}

