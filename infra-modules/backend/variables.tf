
variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "platform_name" {
  description = "The name of the platform"
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "instance_type" {
  type        = string
  description = "Instances type"
}


variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the selected region"
}



variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}


variable "private_route_table_ids" {
  type        = list(string)
  description = "IDs of the created private route tables"
}

variable "context" {
  type = any
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}


variable "associated_security_group_ids" {
  type        = string
  description = "IDs for private subnets"
}


variable "db_connection_string" {
  description = "The MongoDB connection string the lambda will use to connect to Atlas"
  type = string
}

variable "db_username" {
  description = "The username of the account with which to access the database"
  type = string
}

variable "db_password" {
  description = "The password of the account with which to access the database"
  type = string
}

