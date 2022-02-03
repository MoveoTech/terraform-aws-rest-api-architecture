

# SQS
resource "aws_vpc_endpoint" "sqs" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]

  tags = {
    Name = "SQS VPC Endpoint Interface - ${var.stage}"
    Environment = var.stage
  }
}



# Cloudformation
resource "aws_vpc_endpoint" "cloudformation" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.cloudformation"
  vpc_endpoint_type = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]

  tags = {
    Name = "Cloudformation VPC Endpoint Interface - ${var.stage}"
    Environment = var.stage
  }
}


# Elasticbeanstalk Health
resource "aws_vpc_endpoint" "elasticbeanstalk_health" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.elasticbeanstalk-health"
  vpc_endpoint_type = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]

  tags = {
    Name = "Elastic Beanstalk Helath VPC Endpoint Interface - ${var.stage}"
    Environment = var.stage
  }
}

# Elasticbeanstalk
resource "aws_vpc_endpoint" "elasticbeanstalk" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.elasticbeanstalk"
  vpc_endpoint_type = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]

  tags = {
    Name = "Elastic Beanstalk VPC Endpoint Interface - ${var.stage}"
    Environment = var.stage
  }
}


# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]

  tags = {
    Name = "CloudWatch VPC Endpoint Interface - ${var.stage}"
    Environment = var.stage
  }
}

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = var.private_route_table_ids

  tags = {
    Name = "S3 VPC Endpoint Gateway - ${var.stage}"
    Environment = var.stage
  }
}