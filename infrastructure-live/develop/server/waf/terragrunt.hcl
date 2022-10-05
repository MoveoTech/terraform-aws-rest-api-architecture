include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${get_terragrunt_dir()}/../../../_common/waf.hcl"
}
dependencies {
  paths = ["../kms", "../../context", "../api-gateway"]
}


dependency "api_gateway" {
  config_path   = "../api-gateway"
}


dependency "kms" {
  config_path   = "../kms"
}


dependency "context" {
  config_path   = "../../context"
}

inputs={
  association_resource_arns = [dependency.api_gateway.outputs.arn]
  kms_key_arn               = dependency.kms.outputs.key_arn
  context                   =  dependency.context.outputs.context
}