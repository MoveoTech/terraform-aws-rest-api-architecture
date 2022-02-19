
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

resource "aws_kms_key" "default" {
  provider                = aws.east
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = data.aws_iam_policy_document.kms_permissions.json
  tags = merge(module.label.tags, {
    yor_trace = "dc198d05-20b2-48f0-98d5-6a8d5f9387e0"
  })
  description              = var.description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region
}

resource "aws_kms_alias" "default" {
  provider      = aws.east
  name          = "alias/cloudfront_${module.label.stage}"
  target_key_id = aws_kms_key.default.id
}
