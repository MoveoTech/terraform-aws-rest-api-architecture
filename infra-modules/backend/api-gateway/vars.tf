variable "name" {
  type        = string
  description = "The name of the cluster"
}

variable "app_port" {
  type = number 
  description = "The Application port"
}

variable "path_part" {
  type = string 
  description = "The last path segment of this API resource"
}

variable "integration_input_type" {
  type = string 
  description = "The integration input's type."
}

variable "integration_http_method" {
  type = string 
  default = "ANY"
  description = "The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end."
}

variable "environment" {
  type = string
  description = "The application environment"
}

variable "elastic_beanstalk_environment_cname" {
  type = string
  description = "Elastic beanstalk environment name"
}

variable "elastic_beanstalk_application_name" {
  type = string
  description = "Elastic beanstalk application name"
}

variable "nlb_arn" {
  type = string
  description = "Network load balncer arn"
}