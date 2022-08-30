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
variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "memory_size" {
  default     = 128
  description = "Function memory in MB"
  type        = number
}

variable "name" {
  description = "Name assigned to the function and other resources"
  type        = string
}

variable "runtime" {
  default     = "python3.9"
  description = "Lambda runtime to use"
  type        = string
}


variable "timeout" {
  default     = 30
  description = "Function timeout in seconds"
  type        = number
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}


variable "security_group_id" {
  type        = string
  description = "IDs of the created security group"
}
