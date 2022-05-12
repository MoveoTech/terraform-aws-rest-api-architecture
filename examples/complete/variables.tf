variable "public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "private_key" {
  description = "The private API key for MongoDB Atlas"
}


variable "atlas_org_id" {
  description = "The ID of your MongoDB Atlas organisation"
  type        = string
}

variable "module" {
  description = "The terraform module used to deploy"
  type        = string
  default     = null
}
