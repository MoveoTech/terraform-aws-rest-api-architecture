
variable "context" {
  type = any
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