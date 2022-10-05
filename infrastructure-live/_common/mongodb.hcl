# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This is the common component configuration for mysql. The common variables for each environment to
# deploy mysql are defined here. This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
source = "${local.base_source_url}?ref=v${local.version_number}"
}


# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  versions_vars = read_terragrunt_config(find_in_parent_folders("versions.hcl"))


version_number = local.versions_vars.locals.base_architecture_version
  # Extract out common variables for reuse
  env = local.environment_vars.locals.stage
  region = local.environment_vars.locals.region
  atlas_users = local.environment_vars.locals.atlas_users

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  base_source_url = "git::git@github.com:MoveoTech/terraform-aws-rest-api-architecture.git//modules/database"
}
dependencies {
  paths = [ "../../context","../../network","../../server/kms"]
}

dependency "server_kms"{
     config_path   = "../../server/kms"
}


dependency "context" {
  config_path   = "../../context"
}

dependency "network" {
  config_path   = "../../network"
}



inputs = {
  region                      = local.region
  vpc_id                      = dependency.network.outputs.vpc_id
  cidr_block                  = dependency.network.outputs.vpc_cidr_block
  private_subnet_ids          = dependency.network.outputs.private_subnet_ids
  atlas_whitelist_ips         = dependency.network.outputs.nat_gateway_public_ips
  elastic_beanstalk_kms_id    = dependency.server_kms.outputs.key_id
  private_endpoint_enabled    = false
  atlas_users                 = local.atlas_users
  provider_instance_size_name = "M10"
  enable_atlas_whitelist_ips  = true
  enable_database_credentials_secret_manager = true
  context                     = dependency.context.outputs.context

}