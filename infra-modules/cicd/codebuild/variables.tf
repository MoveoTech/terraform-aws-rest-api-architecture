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
