
output "elastic_beanstalk_environment_ec2_instance_profile_role_name" {
  value       = module.elastic_beanstalk.elastic_beanstalk_environment_ec2_instance_profile_role_name
  description = "Instance IAM role name"
}

output "api_gateway_arn" {
  description = "The ARN of the REST API"
  value       = module.api_gateway.arn
}

output "eb_kms_id" {
  value       = module.kms.key_id
  description = "KMS key id"
}

output "eb_key_arn" {
  value       = module.kms.key_arn
  description = "Key ARN"
}


output "elastic_beanstalk_environment_ec2_instance_profile_role_name" {
  value       = module.elastic_beanstalk.elastic_beanstalk_environment_ec2_instance_profile_role_name
  description = "Instance IAM role name"
}

output "elastic_beanstalk_application_name" {
  value       = module.elastic_beanstalk.elastic_beanstalk_application.elastic_beanstalk_application_name
  description = "Elastic Beanstalk Application name"
}

output "elastic_beanstalk_environment_name" {
  value       = module.elastic_beanstalk.elastic_beanstalk_environment.name
  description = "Elastic Beanstalk environment name"
}