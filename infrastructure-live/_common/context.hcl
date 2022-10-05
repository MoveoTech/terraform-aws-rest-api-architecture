terraform{
  source = "${local.base_source_url}?version=0.25.0"
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract out common variables for reuse
  stage = local.environment_vars.locals.stage
  name = local.account_vars.locals.name
  base_source_url = "tfr://registry.terraform.io/cloudposse/label/null"

}

inputs = {
    enabled             = true
    tenant              = null
    environment         = null
    namespace  = null
    stage      = local.stage
    name       = local.name
    attributes = []
    delimiter  = "-"
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = 100
    label_key_case      = "lower"
    label_value_case    = "lower"
    descriptor_formats  = {}
    # Note: we have to use [] instead of null for unset lists due to
    # https://github.com/hashicorp/terraform/issues/28137
    # which was not fixed until Terraform 1.0.0,
    # but we want the default to be all the labels in `label_order`
    # and we want users to be able to prevent all tag generation
    # by setting `labels_as_tags` to `[]`, so we need
    # a different sentinel to indicate "default"
    labels_as_tags = ["unset"]
}