
variable "availability_zones" {
  type = list(string)
}

variable "context" {
  type = any
}

variable "name" {
  type        = string
  description = "Security group name"
}

variable "stage" {
  type        = string
  description = "Stage name"
}

variable "region" {
  type        = string
  description = "AWS region"
}