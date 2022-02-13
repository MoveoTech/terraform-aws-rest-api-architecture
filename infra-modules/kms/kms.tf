module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}
locals {
  alias_name = replace("${module.label.stage}_${module.label.name}", "-", "_")
}


data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_permissions" {
  statement {
    sid = "Enable IAM User Permissions"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow use of the key"
    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }
}


module "kms_key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  description             = "KMS key for secrets manager"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  alias                   = "alias/${local.alias_name}"
  policy                  = data.aws_iam_policy_document.kms_permissions.json
  context                 = var.context
}

