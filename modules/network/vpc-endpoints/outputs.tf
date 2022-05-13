
output "aws_vpc_endpoint_s3" {
  description = "Address of the created vpc endpoint"
  value       = aws_vpc_endpoint.s3.prefix_list_id
}

output "aws_vpc_endpoint_sqs" {
  description = "Address of the created vpc endpoint"
  value       = aws_vpc_endpoint.sqs
}

output "aws_vpc_endpoint_cloudformation" {
  description = "Address of the created vpc endpoint"
  value       = aws_vpc_endpoint.cloudformation
}

output "aws_vpc_endpoint_elasticbeanstalk_health" {
  description = "Address of the created vpc endpoint"
  value       = aws_vpc_endpoint.elasticbeanstalk_health
}

output "aws_vpc_endpoint_elasticbeanstalk" {
  description = "Address of the created vpc endpoint"
  value       = aws_vpc_endpoint.elasticbeanstalk
}