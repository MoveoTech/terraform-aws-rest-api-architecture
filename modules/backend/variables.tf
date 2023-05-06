
variable "region" {
  description = "aws region to deploy to"
  type        = string
}
variable "env_vars" {
  type        = map(string)
  description = "Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env_vars = { DB_USER = 'admin' DB_PASS = 'xxxxxx' }"
}
variable "zone_id" {
  description = "The id of the parent Route53 zone to use for the distribution."
  type        = string
  default     = null
}
variable "acm_request_certificate_arn" {
  description = "Certificate manager ARN"
  type        = string
  default     = null
}
variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
  default     = null
}
variable "instance_type" {
  default     = "t3.micro"
  type        = string
  description = "Instances type"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "context" {
  type = any
  default = {
    enabled             = true
    namespace           = null
    tenant              = null
    environment         = null
    stage               = null
    name                = null
    delimiter           = null
    attributes          = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = null
    label_key_case      = null
    label_value_case    = null
    descriptor_formats  = {}
    # Note: we have to use [] instead of null for unset lists due to
    # https://github.com/hashicorp/terraform/issues/28137
    # which was not fixed until Terraform 1.0.0,
    # but we want the default to be all the labels in `label_order`
    # and we want users to be able to prevent all tag generation
    # by setting `labels_as_tags` to `[]`, so we need
    # a different sentinel to indicate "default"
    labels_as_tags = ["unset"]
  }
  description = <<-EOT
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT

  validation {
    condition     = lookup(var.context, "label_key_case", null) == null ? true : contains(["lower", "title", "upper"], var.context["label_key_case"])
    error_message = "Allowed values: `lower`, `title`, `upper`."
  }

  validation {
    condition     = lookup(var.context, "label_value_case", null) == null ? true : contains(["lower", "title", "upper", "none"], var.context["label_value_case"])
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
  }
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}

variable "associated_security_group_ids" {
  type        = string
  default     = "null"
  description = "IDs for private subnets"
}

variable "user_pool_arn" {
  description = "The ARN of the Cognito user pool"
  type        = string
}

variable "cors_domain" {
  description = "List of all cors domain relevant to the api gateway resource, for example if we want to be able to allow request from client `[www.client.com,client.com]` "
  type        = list(string)
}

variable "autoscale_min" {
  type        = number
  description = "Minumum instances to launch"
}

variable "autoscale_max" {
  type        = number
  description = "Maximum instances to launch"
}

variable "s3_bucket_access_log_bucket_name" {
  type        = string
  description = "Name of the S3 bucket where s3 access log will be sent to"
}


variable "extended_ec2_policy_document" {
  type        = string
  default     = "{}"
  description = "Extensions or overrides for the IAM role assigned to EC2 instances"
}
variable "cognito_enabled" {
  type        = bool
  description = "Allow cognito authorization on api gateway routes"
  default     = false
}

