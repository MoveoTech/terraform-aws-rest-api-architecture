
terraform {
  source = "${local.base_source_url}?ref=v0.12.0"
}


locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  region = local.environment_vars.locals.region

   base_source_url = "git::git@github.com:MoveoTech/terraform-aws-rest-api-architecture.git//modules/kms"
}
