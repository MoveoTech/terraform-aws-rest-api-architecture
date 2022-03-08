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

variable "client_repository_name" {
  type = string
}


variable "client_branch_name" {
  type = string
}

variable "server_repository_name" {
  type = string
}


variable "server_branch_name" {
  type = string
}


variable "elastic_beanstalk_application_name" {
  type        = string
  description = "Elastic beanstalk app name"
}

variable "elastic_beanstalk_environment_name" {
  type        = string
  description = "Elastic beanstalk environment name"
}

variable "codepiplien_name" {
  type        = string
  description = "Pipline name"
  default     = null
}
variable "codebuild_name" {
  type        = string
  description = "Pipline name"
  default     = null
}

variable "client_bucket_name" {
  type = string
  description = "The bucket where the client files are found"
}
