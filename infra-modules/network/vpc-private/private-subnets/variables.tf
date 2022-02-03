variable "context" {
  type        = any
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}


variable "cidr_block" {
  type        = string
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "Availability zones must be greater than zero."
  }
}


variable "enabled" {
  type        = bool
  default     = true
  description = "module enabled"
}

 variable "private_subnets_additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to be added to private subnets"
}
variable "subnet_type_tag_key" {
  type        = string
  default     = "cpco.io/subnet/type"
  description = "Key for subnet type tag to provide information about the type of subnets, e.g. `cpco.io/subnet/type=private` or `cpco.io/subnet/type=public`"
}

variable "subnet_type_tag_value_format" {
  default     = "%s"
  description = "This is using the format interpolation symbols to allow the value of the subnet_type_tag_key to be modified."
  type        = string
}
variable "private_network_acl_id" {
  type        = string
  description = "Network ACL ID that will be added to private subnets. If empty, a new ACL will be created"
  default     = ""
}
variable "nat_elastic_ips" {
  type        = list(string)
  default     = []
  description = "Existing Elastic IPs to attach to the NAT Gateway(s) or Instance(s) instead of creating new ones."
}

variable "availability_zone_attribute_style" {
  type        = string
  default     = "short"
  description = "The style of Availability Zone code to use in tags and names. One of `full`, `short`, or `fixed`."
}

variable "max_subnet_count" {
  default     = 0
  description = "Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region"
}
