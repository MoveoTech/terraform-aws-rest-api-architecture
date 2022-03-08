

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "github_secret_name" {
  type = string
}

variable "github_org" {
  type = string
}

variable "repository_name" {
  type = string
}


variable "branch_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "kms_arn" {
  type        = string
  description = "KMS key to encrypt artifact"
  default = null
}


variable "elastic_beanstalk_application_name" {
  type        = string
  description = "Elastic beanstalk app name"
}

variable "elastic_beanstalk_environment_name" {
  type        = string
  description = "Elastic beanstalk environment name"
}
