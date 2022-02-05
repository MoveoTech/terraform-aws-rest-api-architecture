variable "region" {
  description = "The AWS region this distribution should reside in."
}
variable "context" {
  type = any
}
  variable "domain_name" {
    type        = string
    description = "A domain name for which the certificate should be issued"
    default     = null
  }
variable "acm_certificate_arn" {
  type        = string
  description = "Existing ACM Certificate ARN"
  default     = ""
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "A list of domains that should be SANs in the issued certificate"

  validation {
    condition     = length([for name in var.subject_alternative_names : name if can(regex("[A-Z]", name))]) == 0
    error_message = "All SANs must be lower-case."
  }
}
variable "aliases" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}
variable "parent_zone_name" {
  description = "The name of the parent Route53 zone to use for the distribution."
  type        = string
  default     = null
}
variable "parent_zone_id" {
  description = "The id of the parent Route53 zone to use for the distribution."
  type        = string
  default     = null
}
variable "dns_alias_enabled" {
  type        = bool
  default     = false
  description = "Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name`"
}
variable "additional_custom_origins_enabled" {
  type        = bool
  description = "Whether or not to enable additional custom origins."
  default     = false
}

variable "additional_s3_origins_enabled" {
  type        = bool
  description = "Whether or not to enable additional s3 origins."
  default     = false
}

variable "origin_group_failover_criteria_status_codes" {
  type        = list(string)
  description = "List of HTTP Status Codes to use as the failover criteria for origin groups."
  default = [
    403,
    404,
    500,
    502
  ]
}

variable "lambda_at_edge_enabled" {
  type        = bool
  description = "Whether or not to enable Lambda@Edge functions."
  default     = false
}
