variable "region" {
  type        = string
  description = "The AWS region where resources have been deployed"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "description" {
  type        = string
  default     = "Elastic Beanstalk environment"
  description = "Short description of the Environment"
}

variable "environment_type" {
  type        = string
  default     = "LoadBalanced"
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "loadbalancer_type" {
  type        = string
  default     = "network"
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment"
}

variable "availability_zone_selector" {
  type        = string
  default     = "Any 2"
  description = "Availability Zone selector"
}

variable "instance_type" {
  default     = "t3.micro"
  type        = string
  description = "Instances type"
}

variable "autoscale_min" {
  type        = number
  default     = 1
  description = "Minumum instances to launch"
}

variable "autoscale_max" {
  type        = number
  default     = 2
  description = "Maximum instances to launch"
}


variable "wait_for_ready_timeout" {
  type        = string
  default     = "20m"
  description = "The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out"
}

variable "tier" {
  type        = string
  default     = "WebServer"
  description = "Elastic Beanstalk Environment tier, e.g. 'WebServer' or 'Worker'"
}

variable "version_label" {
  type        = string
  default     = ""
  description = "Elastic Beanstalk Application version to deploy"
}

variable "force_destroy" {
  type        = bool
  default     = true
  description = "Force destroy the S3 bucket for load balancer logs"
}

variable "rolling_update_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable rolling update"
}

variable "rolling_update_type" {
  type        = string
  default     = "Health"
  description = "`Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances"
}

variable "updating_min_in_service" {
  type        = number
  default     = 0
  description = "Minimum number of instances in service during update"
}

variable "updating_max_batch" {
  type        = number
  default     = 1
  description = "Maximum number of instances to update at once"
}

variable "application_port" {
  type        = number
  default     = 80
  description = "Port application is listening on"
}

variable "root_volume_size" {
  type        = number
  default     = 8
  description = "The size of the EBS root volume"
}

variable "root_volume_type" {
  type        = string
  default     = "gp2"
  description = "The type of the EBS root volume"
}

variable "autoscale_measure_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric used for your Auto Scaling trigger"
}

variable "autoscale_statistic" {
  type        = string
  default     = "Average"
  description = "Statistic the trigger should use, such as Average"
}

variable "autoscale_unit" {
  type        = string
  default     = "Percent"
  description = "Unit for the trigger measurement, such as Bytes"
}

variable "autoscale_lower_bound" {
  type        = number
  default     = 20
  description = "Minimum level of autoscale metric to remove an instance"
}

variable "autoscale_lower_increment" {
  type        = number
  default     = -1
  description = "How many Amazon EC2 instances to remove when performing a scaling activity."
}

variable "autoscale_upper_bound" {
  type        = number
  default     = 80
  description = "Maximum level of autoscale metric to add an instance"
}

variable "autoscale_upper_increment" {
  type        = number
  default     = 1
  description = "How many Amazon EC2 instances to add when performing a scaling activity"
}

variable "elb_scheme" {
  type        = string
  default     = "internal"
  description = "Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC"
}

variable "additional_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))

  description = "Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html"
  default = [
    {
      namespace = "aws:elasticbeanstalk:managedactions"
      name      = "ManagedActionsEnabled"
      value     = "false"
    }
  ]
}

variable "env_vars" {
  type = map(string)
  default = {
    "NODE_ENV" = "prod"
  }
  description = "Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env_vars = { DB_USER = 'admin' DB_PASS = 'xxxxxx' }"
}

variable "context" {
  type = any
}
variable "vpc_id" {
  type        = string
  description = "The id for the VPC where the ECS container instance should be deployed"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs for private subnets"
}
variable "associated_security_group_ids" {
  type        = string
  default     = "null"
  description = "IDs for private subnets"
}

variable "ssm_arn" {
  description = "Secrets manager arn for adding to ec2 policy"
  type        = string
}
