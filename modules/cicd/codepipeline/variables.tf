variable "name" {
  description = "Name of pipeline"
  type        = string
}

variable "repository_name" {
  description = "Name of repository"
  type        = string
}

variable "project_name" {
  description = "Name of CodeBuild project"
  type        = string
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
  type        = string
}

variable "environment" {
  type = string
}

variable "kms_arn" {
  type        = string
  description = "KMS key to encrypt artifact"
  default     = null
}

variable "configuration" {
  type        = any
  description = "Deployment configuration"
}
variable "bucket_name" {
  type        = any
  description = "Pipline bucket name"
}

variable "context" {
  type = any
}
variable "deploy_provider" {
  type        = string
  description = "This is the deploy provider type"
}
variable "lambda_name" {
  type        = string
  default     = null
  description = "Lambda function name for invalidate clodfront"
}
variable "cf_distribution_id" {
  type        = string
  default     = null
  description = "Cloudfron distribution id"
}
