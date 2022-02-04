
resource "aws_api_gateway_vpc_link" "this" {
  name = "vpc-link-${module.label.name}"
  target_arns = [var.nlb_arn]
}