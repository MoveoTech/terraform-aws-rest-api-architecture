
variable "region" {
  description = "aws region to deploy to"
  type        = string
}
variable "parent_zone_id" {
  description = "The id of the parent Route53 zone to use for the distribution."
  type        = string
  default     = null
}
variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
  default     = null
}

variable "aliases" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}
variable "dns_alias_enabled" {
  type        = bool
  default     = false
  description = "Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name`"
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
variable "platform_name" {
  description = "The name of the platform"
  type        = string
}


variable "app_port" {
  description = "Application port"
  type        = number
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html"
}

variable "instance_type" {
  type        = string
  description = "Instances type"
}


variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the selected region"
}

