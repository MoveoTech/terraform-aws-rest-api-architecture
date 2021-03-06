
resource "aws_security_group" "atlas_resource" {
  vpc_id      = var.vpc_id
  name        = "${var.context.stage}-atlas-resource-security-group"
  description = "The security group for resources that need to communicate with the Atlas private endpoint"

  egress {
    description = "Https outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
  tags = {
    yor_trace = "584506ee-d6d9-4cd3-b4dc-8d7dfdd55e69"
  }
}

resource "aws_security_group" "atlas_endpoint" {
  vpc_id      = var.vpc_id
  name        = "${var.context.stage}-atlas-endpoint-security-group"
  description = "The security group for the Atlas private endpoint, allowing it to communicate with VPC resources"

  ingress {
    description = "Allow all trafic from range of ips"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }
  tags = {
    yor_trace = "249ed03e-08ed-4eea-925b-fe577bb3e247"
  }
}
