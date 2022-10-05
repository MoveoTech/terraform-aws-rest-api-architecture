include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${get_terragrunt_dir()}/../../../_common/elastic-beanstalk.hcl"
}


inputs={
  env_vars ={
    DB_USER = "admin"
    DB_PASS = "xxxxxx"
    }
  autoscale_max=2
  autoscale_min=1
}