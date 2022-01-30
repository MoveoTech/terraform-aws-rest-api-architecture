output "vpc_arn" {
  value = aws_vpc.custom_vpc.arn
}

output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.*.id
}

output "vpc_default_security_group_id" {
  value       = join("", aws_vpc.custom_vpc.*.default_security_group_id)
  description = "The ID of the security group created by default on VPC creation"
}

output "aws_vpc_endpoint_sqs"{
  value = aws_vpc_endpoint.sqs
}

output "aws_vpc_endpoint_cloudformation"{
  value = aws_vpc_endpoint.cloudformation
}

output "aws_vpc_endpoint_elasticbeanstalk_health"{
  value = aws_vpc_endpoint.elasticbeanstalk_health
}

output "aws_vpc_endpoint_elasticbeanstalk"{
  value = aws_vpc_endpoint.elasticbeanstalk
}