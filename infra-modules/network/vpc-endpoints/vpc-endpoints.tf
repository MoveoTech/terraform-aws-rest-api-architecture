
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

# SQS
resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.sqs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "SQS VPC Endpoint Interface - ${module.label.stage}" })

}



# Cloudformation
resource "aws_vpc_endpoint" "cloudformation" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.cloudformation"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "Cloudformation VPC Endpoint Interface - ${module.label.stage}" })

}


# Elasticbeanstalk Health
resource "aws_vpc_endpoint" "elasticbeanstalk_health" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.elasticbeanstalk-health"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "Elastic Beanstalk Helath VPC Endpoint Interface - ${module.label.stage}" })

}

# Elasticbeanstalk
resource "aws_vpc_endpoint" "elasticbeanstalk" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.elasticbeanstalk"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "Elastic Beanstalk VPC Endpoint Interface - ${module.label.stage}" })

}


# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "CloudWatch VPC Endpoint Interface - ${module.label.stage}" })

}

resource "aws_vpc_endpoint" "kms" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.kms"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "KMS Endpoint Interface - ${module.label.stage}" })

}
resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.private_subnet_ids
  private_dns_enabled = true

  security_group_ids = [var.default_security_group]
  tags               = merge(module.label.tags, { Name = "Secret Manager Endpoint Interface - ${module.label.stage}" })

}

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.private_route_table_ids
  tags              = merge(module.label.tags, { Name = "S3 VPC Endpoint Gateway  - ${module.label.stage}" })
}
