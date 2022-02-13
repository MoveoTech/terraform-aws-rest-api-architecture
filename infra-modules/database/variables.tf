variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "context" {
  type = any
}

variable "atlas_org_id" {
  description = "The ID of your MongoDB Atlas organisation"
  type        = string
}


variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "cidr_block" {
  type        = string
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}


variable "private_subnet_ids" {
  type = list(string)
  description = "IDs for private subnets"
}

variable "atlas_users" {
  type = list(string)
  description = "List of emails for all the developer who needs access to this organization project"
}