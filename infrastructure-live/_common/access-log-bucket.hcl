
terraform {
  source = "${local.base_source_url}?version=0.27.0"
}


locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  stage = local.environment_vars.locals.stage

   base_source_url = "tfr://registry.terraform.io/cloudposse/s3-log-storage/aws"
}
dependencies {
  paths = ["../context"]
}



dependency "context" {
  config_path   = "../context"
}

inputs ={
  name                    = "s3-access-logs"
  block_public_policy     = true
  allow_ssl_requests_only = true
  versioning_enabled      = true
  acl                     = "private"
  sse_algorithm           = "aws:kms"
  context                 = dependency.context.outputs.context
}