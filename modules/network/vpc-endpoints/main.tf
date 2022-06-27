

# SQS
resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "SQS VPC Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "fc6ad378-71f8-4c1a-a18b-002c42753824"
  })

}



# Cloudformation
resource "aws_vpc_endpoint" "cloudformation" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.cloudformation"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "Cloudformation VPC Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "3b41be8f-46e5-492a-8f19-798258e66132"
  })

}


# Elasticbeanstalk Health
resource "aws_vpc_endpoint" "elasticbeanstalk_health" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.elasticbeanstalk-health"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "Elastic Beanstalk Helath VPC Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "7c7888ea-c46f-4672-b12c-71b7fcf9b6dd"
  })

}

# Elasticbeanstalk
resource "aws_vpc_endpoint" "elasticbeanstalk" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.elasticbeanstalk"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "Elastic Beanstalk VPC Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "160b5d4d-b54c-4f4e-8384-f14b1666033c"
  })

}


# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "CloudWatch VPC Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "5fb3190b-0fd7-470a-b214-8d8c48992830"
  })

}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true
  security_group_ids  = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "KMS Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "94c24f37-e9f8-4c0d-9de3-b399db492b97"
  })

}
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "Secret Manager Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "1e1ed177-ac56-4e32-86bb-d4eceacded37"
  })

}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags = merge(var.context.tags, { Name = "EC2 Endpoint Interface - ${var.context.stage}" }, {
    yor_trace = "1e1ed177-ac56-4e32-86bb-d4eceacded22"
  })

}
# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids

  tags = merge(var.context.tags, { Name = "S3 VPC Endpoint Gateway  - ${var.context.stage}" }, {
    yor_trace = "ccad2dc9-ba40-4058-aa90-887b5e3f9006"
  })
}
