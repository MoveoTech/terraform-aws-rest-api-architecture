module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

resource "aws_security_group" "atlas_resource" {
  vpc_id      = var.vpc_id
  name        = "${module.label.name}-${module.label.stage}-atlas-resource-security-group"
  description = "The security group for resources that need to communicate with the Atlas private endpoint"

  egress {
    description = "Https outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
}

resource "aws_security_group" "atlas_endpoint" {
  vpc_id      = var.vpc_id
  name        = "${module.label.name}-${module.label.stage}-atlas-endpoint-security-group"
  description = "The security group for the Atlas private endpoint, allowing it to communicate with VPC resources"

  ingress {
    description = "Allow all trafic from range of ips"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
}
