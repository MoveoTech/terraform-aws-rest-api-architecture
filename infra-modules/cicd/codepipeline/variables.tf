variable "name" {
  description = "Name of pipeline"
  type = string
}

variable "repository_name" {
  description = "Name of repository"
  type = string
}

variable "project_name" {
  description = "Name of CodeBuild project"
  type = string
}

variable "bucket_name" {
  type = string
}

variable "branch_name" {
  type = string
}

variable "region" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_token" {
  description = "Name of github token"
  type = string
}

variable "environment" {
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


variable "context" {
  type = any
}