
variable "availability_zones" {
  type = list(string)
}

variable "context" {
  type = any
}

variable "region" {
  type        = string
  description = "AWS region"
}