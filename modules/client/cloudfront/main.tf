
data "aws_cloudfront_response_headers_policy" "default" {
  name = "Managed-SecurityHeadersPolicy"
}

data "aws_cloudfront_cache_policy" "default" {
  name = "Managed-CachingOptimized"
}

module "cloudfront_s3_cdn" {
  source                     = "cloudposse/cloudfront-s3-cdn/aws"
  version                    = "0.82.4"
  origin_force_destroy       = true
  aliases                    = var.aliases
  dns_alias_enabled          = var.dns_alias_enabled
  parent_zone_id             = var.parent_zone_id
  response_headers_policy_id = data.aws_cloudfront_response_headers_policy.default.id
  cache_policy_id            = data.aws_cloudfront_cache_policy.default.id
  s3_access_logging_enabled  = true
  s3_access_log_prefix       = "logs/s3_access"

  cloudfront_access_logging_enabled = true
  cloudfront_access_log_prefix      = "logs/cf_access"

  custom_error_response = [{
    error_caching_min_ttl = "60"
    error_code            = "404"
    response_code         = "200"
    response_page_path    = "/index.html"
  }]
  acm_certificate_arn = var.acm_certificate_arn
  context             = var.context
}
