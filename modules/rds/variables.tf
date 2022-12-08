
variable "database_port" {
  type        = number
  default     = 5432
  description = "Database port (_e.g._ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids`"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Set to true if multi AZ deployment must be supported"
}

variable "storage_type" {
  type        = string
  default     = "standard"
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
}

variable "allocated_storage" {
  type        = number
  default     = 5
  description = "The allocated storage in GBs"
}

variable "storage_encrypted" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether the DB instance is encrypted. The default is false if not specified"
}

variable "engine" {
  type        = string
  description = "Database engine type"
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # - mysql
  # - postgres
  # - oracle-*
  # - sqlserver-*
}

variable "engine_version" {
  type        = string
  description = "Database engine version, depends on engine type"
  # http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
}

variable "instance_class" {
  type        = string
  description = "Class of RDS instance"
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

variable "db_parameter_group" {
  type        = string
  description = "Parameter group, depends on DB engine used"
  # "mysql5.6"
  # "postgres9.5"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Determines if database can be publicly available (NOT recommended)"
}

variable "vpc_id" {
  type        = string
  description = "The id for the VPC where the ECS container instance should be deployed"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs for private subnets"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "IDs for vpc default security group ids"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
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
