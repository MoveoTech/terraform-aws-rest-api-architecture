
data "aws_canonical_user_id" "current" {
  count = 1
}

module "s3_bucket" {
  source              = "cloudposse/s3-bucket/aws"
  version             = "0.49.0"
  block_public_policy = true
  acl                 = "private"
  force_destroy       = true
  user_enabled        = false
  versioning_enabled  = false
  attributes          = ["existing-bucket"]

  grants = [
    {
      id          = var.context.enabled ? data.aws_canonical_user_id.current[0].id : ""
      type        = "CanonicalUser"
      permissions = ["FULL_CONTROL"]
      uri         = null
    },
    {
      id          = null
      type        = "Group"
      permissions = ["READ_ACP", "WRITE"]
      uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
    },
  ]

  context = var.context
}

data "aws_cloudfront_response_headers_policy" "default" {
  name = "Managed-SecurityHeadersPolicy"
}

data "aws_cloudfront_cache_policy" "default" {
  name = "Managed-CachingOptimized"
}

module "cloudfront_s3_cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.82.2"

  web_acl_id                 = module.waf_cloudfront.arn
  aliases                    = var.aliases
  dns_alias_enabled          = var.dns_alias_enabled
  parent_zone_id             = var.parent_zone_id
  response_headers_policy_id = data.aws_cloudfront_response_headers_policy.default.id
  cache_policy_id            = data.aws_cloudfront_cache_policy.default.id
  s3_access_logging_enabled  = true
  s3_access_log_bucket_name  = module.s3_bucket.bucket_id
  s3_access_log_prefix       = "logs/s3_access"

  cloudfront_access_logging_enabled = true
  cloudfront_access_log_prefix      = "logs/cf_access"

  custom_error_response = [{
    error_caching_min_ttl = "60"
    error_code            = "404"
    response_code         = "200"
    response_page_path    = "/index.html"
  }]
  s3_origins = [{
    domain_name = module.s3_bucket.bucket_regional_domain_name
    origin_id   = module.s3_bucket.bucket_id
    origin_path = null
    s3_origin_config = {
      origin_access_identity = null # will get translated to the origin_access_identity used by the origin created by this module.
    }
  }]
  origin_groups = [{
    primary_origin_id  = null # will get translated to the origin id of the origin created by this module.
    failover_origin_id = module.s3_bucket.bucket_id
    failover_criteria = [
      403,
      404,
      500,
      502
    ]
  }]

  acm_certificate_arn = var.acm_certificate_arn
  context             = var.context
}


resource "aws_s3_bucket_object" "index" {
	# checkov:skip=CKV_AWS_186: s3 website not support kms


  bucket       = module.cloudfront_s3_cdn.s3_bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/index.html"))
  tags         = var.context.tags
  
}
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}


module "kms" {
  source       = "./kms"
  context      = var.context
}
module "waf_cloudfront" {
  source      = "../../waf"
  kms_key_arn = module.kms.key_arn
  providers = {
    aws = aws.east
  }
  scope   = "CLOUDFRONT"
  type    = "cloudfront"
  context = var.context
}
