
variable "name" {
  description = "The name of the Build"
  type        = string
}

variable "environment" {
  type = string
}


variable "image" {
  description = "CodeBuild Container base image"
  type        = string
}

variable "context" {
  type = any
}

variable "kms_arn" {
  type        = string
  description = "KMS key to encrypt artifact"
  default = null
}
variable "buildspec_path" {
  type        = string
  description = "The build spec path in th context of the github repository project"
  default = "buildspec.yml"
}
variable "environment_variables" {
  type = list(object(
    {
      name  = string
      value = string
      type  = string
  }))

  default = [
    {
      name  = "NO_ADDITIONAL_BUILD_VARS"
      value = "TRUE"
      type  = "PLAINTEXT"
  }]

  description = "A list of maps, that contain the keys 'name', 'value', and 'type' to be used as additional environment variables for the build. Valid types are 'PLAINTEXT', 'PARAMETER_STORE', or 'SECRETS_MANAGER'"
}