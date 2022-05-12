
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
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

