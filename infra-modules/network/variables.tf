
variable "region" {
  type        = string
  description = "AWS region"
}
variable "context" {
  type = any
}
variable "availability_zones" {
  type = list(string)
}
