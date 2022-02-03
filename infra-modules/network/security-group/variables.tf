variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}

variable "name" {
  type        = string
  description = "Security group name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Vpc cidr block"
}

variable "s3_prefix_list_id" {
  type        = string
  description = "s3_prefix_list_id"
}

variable "stage" {
  type        = string
  description = "Stage"
}