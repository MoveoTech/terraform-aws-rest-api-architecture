
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

variable "client_callback_urls" {
  description = "List of allowed callback URLs for the identity providers"
  type        = list(string)
  default     = []
}

variable "client_default_redirect_uri" {
  description = "The default redirect URI. Must be in the list of callback URLs"
  type        = string
  default     = null
}


variable "client_logout_urls" {
  description = "List of allowed logout URLs for the identity providers"
  type        = list(string)
  default     = []
}

variable "cognito_default_user_email" {
  type        = string
  description = "This is a default user to be able to login to the system"
}

variable "schemas" {
  description = "A container with the schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

variable "string_schemas" {
  description = "A container with the string schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

variable "generate_secret" {
  description = "Generate a user secret."
  type        = bool
  default     = false
}

variable "number_schemas" {
  description = "A container with the number schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

variable "client_read_attributes" {
  description = "List of user pool attributes the application client can read from"
  type        = list(string)
  default     = []
}

variable "client_write_attributes" {
  description = "List of user pool attributes the application client can write to"
  type        = list(string)
  default     = []
}

variable "user_pool_name" {
  description = "User poll name. concatenated with the environment name"
  type        = string
  default     = ""
}
variable "domain_name" {
  description = "Domain name. concatenated with the environment name"
  type        = string
  default     = ""
}

variable "clients_access_token_validity_hours_amount" {
  description = "The amount of hours a client's access token should be valid"
  type        = number
  default     = 1
}
variable "clients_id_token_validity_hours_amount" {
  description = "The amount of hours a client's id token should be valid"
  type        = number
  default     = 1
}
variable "clients_refresh_token_validity_hours_amount" {
  description = "The amount of hours a client's access token should be valid"
  type        = number
  default     = 12
}

variable "explicit_auth_flows" {
  description = "List of explicit auth flows"
  type        = list(string)
  default     = []
}

variable "verification_message_template" {
  description = "The template of the sign-up verification message"
  type        = object({ default_email_option = string, email_message = optional(string), email_subject = optional(string), sms_message = optional(string) })
  default = {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "{username}, your verification code is `{####}`"
    email_subject        = "Your verification code"
    sms_message          = "This is the verification message {####}."
  }
}

variable "admin_create_user_config" {
  description = "The configuration for AdminCreateUser requests"
  type        = object({
    email_message = optional(string),
    email_subject = optional(string),
    sms_message = optional(string),
  })
  default = {
    email_message = "Dear {username}, your verification code is {####}."
    email_subject = "Verification code"
    sms_message   = "Your username is {username} and temporary password is {####}."
  }
}

variable "password_policy" {
  description = "The configuration for the generated user pool's password policy"
  type        = object({
    minimum_length = optional(number)
    require_lowercase = optional(bool)
    require_numbers = optional(bool)
    require_symbols = optional(bool)
    require_uppercase = optional(bool)
    temporary_password_validity_days = optional(number)
  })
  default = {
    minimum_length                   = 12
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = false
    require_uppercase                = false
    temporary_password_validity_days = 7
  }
}
