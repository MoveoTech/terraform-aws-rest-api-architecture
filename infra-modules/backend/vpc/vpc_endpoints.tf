

# SQS
resource "aws_vpc_endpoint" "sqs" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.eb_tasks.id}",
  ]

  tags = {
    Name = "SQS VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}



# Cloudformation
resource "aws_vpc_endpoint" "cloudformation" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.cloudformation"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.eb_tasks.id}",
  ]

  tags = {
    Name = "Cloudformation VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}


# Elasticbeanstalk Health
resource "aws_vpc_endpoint" "elasticbeanstalk_health" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.elasticbeanstalk-health"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.eb_tasks.id}",
  ]

  tags = {
    Name = "Elastic Beanstalk Helath VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}

# Elasticbeanstalk
resource "aws_vpc_endpoint" "elasticbeanstalk" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.elasticbeanstalk"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.eb_tasks.id}",
  ]

  tags = {
    Name = "Elastic Beanstalk VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}


# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.eb_tasks.id}",
  ]

  tags = {
    Name = "CloudWatch VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [var.main_pvt_route_table_id]

  tags = {
    Name = "S3 VPC Endpoint Gateway - ${var.environment}"
    Environment = var.environment
  }
}