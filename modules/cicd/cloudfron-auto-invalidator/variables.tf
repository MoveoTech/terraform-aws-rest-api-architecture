variable "context" {
  type = any
}

variable "memory_size" {
  default     = 128
  description = "Function memory in MB"
  type        = number
}

variable "name" {
  description = "Name assigned to the function and other resources"
  type        = string
}

variable "runtime" {
  default     = "python3.6"
  description = "Lambda runtime to use"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to be assigned to all resources"
  type        = map(string)
}

variable "timeout" {
  default     = 30
  description = "Function timeout in seconds"
  type        = number
}


variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}


variable "security_group_id" {
  type        = string
  description = "IDs of the created security group"
}
