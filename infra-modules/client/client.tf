provider "aws" {
  region = var.region
}

locals {
  enabled = true
}

module "acm_request_certificate" {
  source  = "./acm"
  zone_id = var.parent_zone_id
}

module "lambda_at_edge" {
  source  = "./lambda"
  context = module.this.context
}

data "aws_canonical_user_id" "current" {
  count = local.enabled ? 1 : 0
}

module "s3_bucket" {
  source              = "cloudposse/s3-bucket/aws"
  version             = "0.36.0"
  block_public_policy = true
  acl                 = null
  force_destroy       = true
  user_enabled        = false
  versioning_enabled  = false
  attributes          = ["existing-bucket"]

  grants = [
    {
      id          = local.enabled ? data.aws_canonical_user_id.current[0].id : ""
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

  context = module.this.context
}

module "cloudfront_s3_cdn" {
  source = "cloudposse/cloudfront-s3-cdn/aws"
  # Cloud Posse recommends pinning every module to a specific version
  version   = "0.82.2"
  namespace = "moveo-test"
  stage     = "prod"
  name      = "app"
  aliases   = ["elirana.moveodevelop.com", "www.elirana.moveodevelop.com"]

  # website_enabled             = true
  # s3_website_password_enabled = true
  dns_alias_enabled = true
  parent_zone_id    = "ZZG2X8KI3MIQB"

  s3_access_logging_enabled = true
  s3_access_log_bucket_name = module.s3_bucket.bucket_id
  s3_access_log_prefix      = "logs/s3_access"

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

  acm_certificate_arn = module.acm_request_certificate.acm_request_certificate_arn
  # lambda_function_association = module.lambda_at_edge.lambda_function_association
  depends_on = [module.acm_request_certificate]
}


resource "aws_s3_bucket_object" "index" {


  bucket       = module.cloudfront_s3_cdn.s3_bucket
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = md5(file("${path.module}/index.html"))
  tags         = module.this.tags
}
