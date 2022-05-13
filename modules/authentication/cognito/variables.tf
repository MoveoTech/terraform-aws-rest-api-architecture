
variable "context" {
  type = any
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