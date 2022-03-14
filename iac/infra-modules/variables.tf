variable "module" {
  description = "The terraform module used to deploy"
  type        = string
}
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

variable "aliases_client" {
  type        = list(string)
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default     = []
}
variable "aliases_server" {
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

variable "instance_type" {
  type        = string
  description = "Instances type"
}


variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the selected region"
}

variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}


variable "atlas_org_id" {
  description = "The ID of your MongoDB Atlas organisation"
  type        = string
}



variable "atlas_users" {
  type = list(string)
  description = "List of emails for all the developer who needs access to this organization project"
}


variable "client_callback_urls" {
  description = "List of allowed callback URLs for the identity providers"
  type        = list(string)
  default     = ["http://localhost:3000"]
}

variable "client_default_redirect_uri" {
  description = "The default redirect URI. Must be in the list of callback URLs"
  type        = string
  default     = "http://localhost:3000"
}


variable "client_logout_urls" {
  description = "List of allowed logout URLs for the identity providers"
  type        = list(string)
  default     = ["http://localhost:3000/logout"]
}


variable "github_secret_name" {
  type = string
}

variable "github_org" {
  type = string
}

variable "client_repository_name" {
  type = string
}


variable "client_branch_name" {
  type = string
}

variable "server_repository_name" {
  type = string
}


variable "server_branch_name" {
  type = string
}

variable "cognito_default_user_email" {
  type = string
  description = "This is a default user to be able to login to the system"
}


variable "private_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Private endpoint allow to connect between 2 aws accounts by private network no need to use internet. To use this feature you need to add payment card to your atlas account"
}


variable "enable_atlas_whitelist_ips" {
  type        = bool
  default     = false
  description = "Enable the withelist ip, if it enabled the ip's taken from the AWS EIP"
}

variable "atlas_whitelist_ips" {
  type        = list(string)
  default     = []
  description = "A list of ip's that need access to this project clusters"
}