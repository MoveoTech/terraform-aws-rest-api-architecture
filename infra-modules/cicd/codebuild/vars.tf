variable "name" {
  description = "The name of the Build"
  type        = string
}

variable "environment" {
  type = string
}


variable "image" {
  description = "CodeBuild Container base image"
  type = string
}

