terraform {
  source = "${local.base_source_url}?ref=v${local.version_number}"
}

locals {
  # Automatically load environment-level variables
  versions_vars = read_terragrunt_config(find_in_parent_folders("versions.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  version_number = local.versions_vars.locals.base_architecture_version
  client_repository_name = local.account_vars.locals.client_repository_name
  client_branch_name = local.account_vars.locals.client_branch_name
  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  base_source_url = "git::git@github.com:MoveoTech/terraform-aws-rest-api-architecture.git//modules/client/amplify"
}

dependencies {
  paths = ["../context", "../network"]
}

dependency "context" {
  config_path = "../context"
}

dependency "network" {
  config_path = "../network"
}

inputs = {
  name                        = "${dependency.context.outputs.context.name}_${dependency.context.outputs.context.stage}"
  enable_auto_branch_creation = true
  client_repository_name      = local.client_repository_name
  enable_auto_build           = true
  client_branch_name          = local.client_branch_name
}
