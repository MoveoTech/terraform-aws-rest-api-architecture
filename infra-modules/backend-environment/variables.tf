variable "module" {
  description = "The terraform module used to deploy"
  type        = string
}

variable "profile" {
  description = "AWS profile"
  type        = string
}

variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "platform_name" {
  description = "The name of the platform"
  type = string
}

variable "environment" {
  description = "Applicaiton environment"
  type = string
}

variable "app_port" {
  description = "Application port"
  type = number
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html"
}

variable "instance_type" {
  type        = string
  description = "Instances type"
}


variable "availability_zones" {
  type  = list(string)
  description = "List of availability zones for the selected region"
}



variable "main_pvt_route_table_id" {
  type        = string
  description = "Main route table id"
}