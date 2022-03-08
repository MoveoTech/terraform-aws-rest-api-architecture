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
