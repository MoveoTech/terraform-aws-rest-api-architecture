variable "enable_database_credentials_secret_manager" {
  description = "Indicate whether or not creating secret manager from the database module"
  type        = string
  default     = false
}
variable "elastic_beanstalk_kms_id" {
  description = "Elastic beanstalk kms key to encrypt the secrets"
  type        = string
  default     = null
}
variable "region" {
  type        = string
  description = "AWS region"
}

variable "enable_atlas_whitelist_ips" {
  type        = bool
  description = "Enable the whitelist ip, if it enabled the ip's taken from the AWS EIP"
}
variable "provider_instance_size_name" {
  type        = string
  description = "Atlas provides different instance sizes, each with a default storage capacity and RAM size"
}

variable "mongo_db_major_version" {
  type        = string
  description = "Version of the cluster to deploy. Atlas supports the following MongoDB versions for M10+ clusters: 4.2, 4.4, 5.0, or 6.0."
  default     = "6.0"
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

variable "atlas_org_id" {
  description = "The ID of your MongoDB Atlas organisation"
  type        = string
  default     = null
}

variable "team_id" {
  description = "The unique identifier of the team you want to associate with the project. The team and project must share the same parent organization."
  type        = string
  default     = null
}

variable "role_names" {
  description = "Each string in the array represents a project role you want to assign to the team. Every user associated with the team inherits these roles. You must specify an array even if you are only associating a single role with the team"
  type        = list(string)
  default     = []
}

variable "private_key" {
  description = "Atlas MongoDB private key for authentication"
  type        = string
  default     = null
}
variable "public_key" {
  description = "Atlas MongoDB public key for authentication"
  type        = string
  default     = null
}


variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "cidr_block" {
  type        = string
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}

variable "private_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Private endpoint allow to connect between 2 aws accounts by private network no need to use internet. To use this feature you need to add payment card to your atlas account"
}


variable "atlas_whitelist_ips" {
  type        = list(string)
  default     = []
  description = "A list of ip's that need access to this project clusters"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs for private subnets"
}

variable "atlas_users" {
  type        = list(string)
  description = "List of emails for all the developer who needs access to this organization project"
}

