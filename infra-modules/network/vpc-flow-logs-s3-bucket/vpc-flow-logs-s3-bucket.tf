  module "flow_logs" {
    source  = "cloudposse/vpc-flow-logs-s3-bucket/aws"
    version = "0.16.2"

    flow_log_enabled                   = var.flow_log_enabled
    lifecycle_prefix                   = var.lifecycle_prefix
    lifecycle_rule_enabled             = var.lifecycle_rule_enabled
    noncurrent_version_expiration_days = var.noncurrent_version_expiration_days
    noncurrent_version_transition_days = var.noncurrent_version_transition_days
    standard_transition_days           = var.standard_transition_days
    glacier_transition_days            = var.glacier_transition_days
    expiration_days                    = var.expiration_days
    traffic_type                       = var.traffic_type
    allow_ssl_requests_only            = var.allow_ssl_requests_only
    vpc_id                             = var.vpc_id

    context = var.context
  }