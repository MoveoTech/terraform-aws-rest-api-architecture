output "cf_id" {
  value       = try(module.cloudfront_s3_cdn.default[0].id, "")
  description = "ID of AWS CloudFront distribution"
}

output "cf_arn" {
  value       = try(module.cloudfront_s3_cdn.default[0].arn, "")
  description = "ARN of AWS CloudFront distribution"
}

output "cf_status" {
  value       = try(module.cloudfront_s3_cdn.default[0].status, "")
  description = "Current status of the distribution"
}

output "cf_domain_name" {
  value       = try(module.cloudfront_s3_cdn.default[0].domain_name, "")
  description = "Domain name corresponding to the distribution"
}

output "cf_etag" {
  value       = try(module.cloudfront_s3_cdn.default[0].etag, "")
  description = "Current version of the distribution's information"
}

output "cf_hosted_zone_id" {
  value       = try(module.cloudfront_s3_cdn.default[0].hosted_zone_id, "")
  description = "CloudFront Route 53 zone ID"
}
