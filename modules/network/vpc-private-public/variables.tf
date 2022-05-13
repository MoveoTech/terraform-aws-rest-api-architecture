variable "context" {
  type = any
}

variable "availability_zones" {
  type = list(string)
}

variable "region" {
  type        = string
  description = "AWS region"
}