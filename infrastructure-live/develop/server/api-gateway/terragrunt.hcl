include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${get_terragrunt_dir()}/../../../_common/api-gateway.hcl"
}


dependencies {
  paths = ["../../cognito","../kms", "../../context", "../elastic-beanstalk","../certificate-manager"]
}

dependency "certificate_manager" {
  config_path   = "../certificate-manager"
}

dependency "kms" {
  config_path   = "../kms"
}

dependency "context" {
  config_path   = "../../context"
}

dependency "elastic_beanstalk" {
  config_path   = "../elastic-beanstalk"
}
dependency "cognito" {
  config_path   = "../../cognito"
}


inputs={
  acm_request_certificate_arn = dependency.certificate_manager.outputs.acm_request_certificate_arn
  user_pool_arn = dependency.cognito.outputs.user_pool_arn
  cors_domain = []
  integration_input_type              = "HTTP_PROXY"
  path_part                           = "{proxy+}"
  nlb_arn                             = dependency.elastic_beanstalk.outputs.load_balancers_arn
  elastic_beanstalk_environment_cname = dependency.elastic_beanstalk.outputs.load_balancers_arn
  elastic_beanstalk_application_name  = dependency.context.outputs.context.name
  context                             = dependency.context.outputs.context
  kms_key_arn                         = dependency.kms.outputs.key_arn
  cognito_enabled                     = false
  context                             = dependency.context.outputs.context
}