terraform {
  source = "${local.base_source_url}?ref=v${local.version_number}"
}

locals {
  # Automatically load environment-level variables
  versions_vars = read_terragrunt_config(find_in_parent_folders("versions.hcl"))

  version_number = local.versions_vars.locals.base_architecture_version

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
