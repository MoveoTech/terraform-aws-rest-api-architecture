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
  environment_vars                            = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  versions_vars                               = read_terragrunt_config(find_in_parent_folders("versions.hcl"))

  version_number                              = local.versions_vars.locals.base_architecture_version
  # Extract out common variables for reuse
  env                                         = local.environment_vars.locals.stage
  cognito_default_user_email                  = local.environment_vars.locals.cognito_default_user_email

  # Uncomment if you need to override the the default variables in the imported modules.
  # admin_create_user_config                    = local.environment_vars.locals.admin_create_user_config
  # password_policy                             = local.environment_vars.locals.password_policy
  # verification_message_template               = local.environment_vars.locals.verification_message_template
  # clients_access_token_validity_hours_amount  = local.environment_vars.locals.clients_access_token_validity_hours_amount
  # clients_id_token_validity_hours_amount      = local.environment_vars.locals.clients_id_token_validity_hours_amount
  # clients_refresh_token_validity_hours_amount = local.environment_vars.locals.clients_refresh_token_validity_hours_amount

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  base_source_url                             = "git::git@github.com:MoveoTech/terraform-aws-rest-api-architecture.git//modules/authentication/cognito"
}
dependencies {
  paths = [ "../context"]
}
dependency "context" {
  config_path   = "../context"
}

inputs = {
  client_callback_urls                        = ["http://localhost:3000"]
  cognito_default_user_email                  = local.cognito_default_user_email
  context                                     = dependency.context.outputs.context

  # Uncomment if you need to override the the default variables in the imported modules.
  # admin_create_user_config                    = local.admin_create_user_config
  # password_policy                             = local.password_policy
  # verification_message_template               = local.verification_message_template
  # clients_access_token_validity_hours_amount  = local.clients_access_token_validity_hours_amount
  # clients_id_token_validity_hours_amount      = local.clients_id_token_validity_hours_amount
  # clients_refresh_token_validity_hours_amount = local.clients_refresh_token_validity_hours_amount
}