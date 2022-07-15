
resource "aws_security_group" "default" {
  name        = var.context.stage
  description = "${var.context.stage} Default security group"
  vpc_id      = var.vpc_id
  tags = merge(var.context.tags, { Name = "Default Security Group" }, {
    yor_trace = "955e8433-eb32-477d-8ac8-34903d428a1f"
  })


  ingress {
    description = "Https incoming traffic"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    description = "Allow all outgoing trafic"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    prefix_list_ids = [
      var.s3_prefix_list_id
    ]
    cidr_blocks = ["0.0.0.0/0"]
  }
}
