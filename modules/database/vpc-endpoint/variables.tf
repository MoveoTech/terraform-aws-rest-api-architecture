
variable "project_id" {
  description = "Atlas database prodect ID"
  type        = string
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}


variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}
variable "security_group_id" {
  type        = string
  description = "Security group id"
}
