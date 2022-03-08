variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = <<-DOC
    Specifies whether this is for an AWS CloudFront distribution or for a regional application.
    Possible values are `CLOUDFRONT` or `REGIONAL`.
    To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
  DOC
  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.scope)
    error_message = "Allowed values: `CLOUDFRONT`, `REGIONAL`."
  }
}



variable "association_resource_arns" {
  type        = list(string)
  default     = []
  description = <<-DOC
    A list of ARNs of the resources to associate with the web ACL.
    This must be an ARN of an Application Load Balancer or an Amazon API Gateway stage.
  DOC
}
variable "kms_key_arn" {
  type = string
  description = "The KMS arn key to encrtypt all logs "
}
variable "type" {
  type = string
  description = "This is for the cloud watch naming"
}

variable "context" {
  type = any
}