variable "name" {
  type        = string
  description = "name of the application"
}

variable "enable_auto_build" {
  type        = bool
  default     = false
  description = "build automatically"
}

variable "client_repository_name" {
  type        = string
  description = "client repository link "
}

variable "enable_auto_branch_creation" {
  type        = bool
  description = "should enable auto branch creation in amplify?"
}

variable "branch" {
  type        = string
  description = "Which branch to fetch from?"
}
