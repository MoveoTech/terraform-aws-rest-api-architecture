
variable "s3_bucket_access_log_bucket_name" {
  type        = string
  description = "Name of the S3 bucket where s3 access log will be sent to"
}
variable "name" {
  description = "Name of pipeline"
  type        = string
}

variable "repository_name" {
  description = "Name of repository"
  type        = string
}

variable "project_name" {
  description = "Name of CodeBuild project"
  type        = string
}


variable "branch_name" {
  description = "Branch name"
  type        = string
}

variable "github_org" {
  description = "GitHub organization name"
  type        = string
}

variable "github_token" {
  description = "Name of github token"
  type        = string
}

variable "kms_arn" {
  type        = string
  description = "KMS key to encrypt artifact"
  default     = null
}

variable "configuration" {
  type        = any
  description = "Deployment configuration"
}
variable "bucket_name" {
  type        = any
  description = "Pipline bucket name"
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
variable "deploy_provider" {
  type        = string
  description = "This is the deploy provider type"
}
variable "lambda_name" {
  type        = string
  default     = null
  description = "Lambda function name for invalidate clodfront"
}
variable "cf_distribution_id" {
  type        = string
  default     = null
  description = "Cloudfron distribution id"
}
