include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${get_terragrunt_dir()}/../../../_common/certificate-manager.hcl"
}


inputs={
  enabled                   = false
  domain_name               = null
  zone_id                   = null
}