provider "aws" {
  region = "us-east-1"
  alias  = "east"
}


# create acm and explicitly set it to us-east-1 provider
module "acm_request_certificate" {
  source = "cloudposse/acm-request-certificate/aws"
  providers = {
    aws = aws.east
  }

  version                           = "0.16.0"
  zone_id                           = var.zone_id
  domain_name                       = "elirana.moveodevelop.com"
  subject_alternative_names         = ["www.elirana.moveodevelop.com"]
  process_domain_validation_options = true
  wait_for_certificate_issued       = true
  ttl                               = "60"
}
