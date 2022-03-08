
variable "alias_name" {
  description = "KMS alias name"
  default     = null
  type        = string
}
variable "context" {
  type = any
}
variable "service_name" {
  type        = list(string)
  default     = []
  description = "The name of the service you want to give a permission to use the key"
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}