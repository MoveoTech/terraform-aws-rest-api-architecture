
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}


# Traffic to the ECS Cluster should only come from the ALB
# or AWS services through an AWS PrivateLink
resource "aws_security_group" "default" {
  name        = "${module.label.name}-${module.label.stage}"
  description = "${module.label.name}-${module.label.stage} Default security group"
  vpc_id      = var.vpc_id
  tags        = merge(module.label.tags, { Name = "Default Security Group" })


  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    prefix_list_ids = [
      var.s3_prefix_list_id
    ]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
