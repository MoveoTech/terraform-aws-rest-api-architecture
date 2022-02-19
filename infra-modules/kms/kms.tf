
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

locals {
  account_id     = data.aws_caller_identity.current.account_id
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
    sid       = "Allow access for Key Administrators"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
        "arn:aws:iam::${local.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
      ]
    }
  }
  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
        "arn:aws:iam::${local.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
      ]
    }
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
        "arn:aws:iam::${local.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}


module "kms_key" {
  source  = "cloudposse/kms-key/aws"
  version = "0.12.1"

  multi_region            = var.multi_region
  description             = "KMS key for secrets manager"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  alias                   = "alias/${var.alias_name}"
  policy                  = data.aws_iam_policy_document.kms_permissions.json
  context                 = var.context
}

