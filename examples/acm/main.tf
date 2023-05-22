
module "acm_request_certificate_server" {
  source      = "../../modules/acm"
  enabled     = false
  domain_name = "domain.com"
  zone_id     = null
}
