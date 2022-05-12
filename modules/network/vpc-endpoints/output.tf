
output "aws_vpc_endpoint_s3"{
  value = aws_vpc_endpoint.s3.prefix_list_id
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