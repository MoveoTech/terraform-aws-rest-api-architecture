
locals {
  enabled     = var.enabled && var.domain_name != null ? true : false
  domain_name = local.enabled ? var.domain_name : ""
}




# create acm and explicitly set it to us-east-1 provider
module "acm_request_certificate" {
  source                            = "cloudposse/acm-request-certificate/aws"
  enabled                           = local.enabled
  version                           = "0.18.0"
  zone_id                           = var.zone_id
  domain_name                       = local.domain_name
  subject_alternative_names         = var.subject_alternative_names
  process_domain_validation_options = true
  wait_for_certificate_issued       = true
  ttl                               = "60"
}
