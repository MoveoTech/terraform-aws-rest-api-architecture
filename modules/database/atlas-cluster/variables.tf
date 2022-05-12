
variable "region" {
  type        = string
  description = "AWS region"
}

variable "context" {
  type = any
}

variable "atlas_project_id" {
  description = "The ID of your MongoDB Atlas project"
  type        = string
}