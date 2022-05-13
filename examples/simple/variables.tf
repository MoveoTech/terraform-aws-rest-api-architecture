variable "public_key" {
  description = "The public API key for MongoDB Atlas"
  type        = string
}
variable "private_key" {
  type        = string
  description = "The private API key for MongoDB Atlas"
}


variable "atlas_org_id" {
  description = "The ID of your MongoDB Atlas organisation"
  type        = string
}