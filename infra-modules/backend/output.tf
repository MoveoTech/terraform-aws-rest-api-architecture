
output "elastic_beanstalk_environment_ec2_instance_profile_role_name" {
  value       = module.elastic_beanstalk.elastic_beanstalk_environment_ec2_instance_profile_role_name
  description = "Instance IAM role name"
}

output "api_gateway_arn" {
  description = "The ARN of the REST API"
  value       = module.api_gateway.arn
}