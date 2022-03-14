variable "context" {
  type = any
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
  type        = string
  description = "The bucket where the client files are found"
}
variable "cognito_pool_id" {
  type        = string
  description = "Cognito pool id to configure the authentication"
}
variable "cognito_web_client_id" {
  type        = string
  description = "Cognito web client id to configure the authentication"
}

variable "invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod"
  type        = string
}



variable "cloudfront_arn" {
  type = string
  description = "Cloudfront arn"
  
}

variable "cf_distribution_id" {
  type = string
  description = "Cloudfront distribution id"
  
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}