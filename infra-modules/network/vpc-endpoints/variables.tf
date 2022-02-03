variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "cidr_block" {
  type        = string
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}
variable "default_security_group" {
  type        = string
  description = "Defualt security group"
}
variable "stage" {
  type        = string
  description = "stage"
}
variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}

variable "private_route_table_ids" {
  type        = list(string)
  description = "IDs of the created private route tables"
}

variable "region" {
  type        = string
  description = "AWS region"
}