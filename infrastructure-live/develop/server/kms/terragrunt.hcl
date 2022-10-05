include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${get_terragrunt_dir()}/../../../_common/kms.hcl"
  expose = true
}
dependencies {
  paths = ["../../context"]
}

dependency "context" {
  config_path   = "../../context"
}

inputs={
      region = include.envcommon.locals.region
      alias_name = "eb-backend-${include.envcommon.locals.region}"
      context                 = dependency.context.outputs.context
}