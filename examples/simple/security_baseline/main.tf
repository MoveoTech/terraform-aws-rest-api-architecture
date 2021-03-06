
data "aws_caller_identity" "current" {
}


resource "aws_iam_user" "admin" {
  name = "admin"
}

module "secure_baseline" {
  source  = "nozaq/secure-baseline/aws"
  version = "0.34.0"

  audit_log_bucket_name           = var.audit_s3_bucket_name
  aws_account_id                  = data.aws_caller_identity.current.account_id
  region                          = var.region
  support_iam_role_principal_arns = [aws_iam_user.admin.arn]
  target_regions                  = [var.region]
  vpc_flow_logs_destination_type  = "s3"
  audit_log_bucket_key_enabled    = true
  # s3_restrict_public_buckets      = true
  # vpc_flow_logs_retention_in_days = 365
  # Setting it to true means all audit logs are automatically deleted
  #   when you run `terraform destroy`.
  # Note that it might be inappropriate for highly secured environment.
  audit_log_bucket_force_destroy = true

  # This module only configure regions specified in target_regions argument though,
  # all providers still need to be passed to the module.
  providers = {
    # aws                = aws
    aws.ap-northeast-1 = aws.ap-northeast-1
    aws.ap-northeast-2 = aws.ap-northeast-2
    aws.ap-northeast-3 = aws.ap-northeast-3
    aws.ap-south-1     = aws.ap-south-1
    aws.ap-southeast-1 = aws.ap-southeast-1
    aws.ap-southeast-2 = aws.ap-southeast-2
    aws.ca-central-1   = aws.ca-central-1
    aws.eu-central-1   = aws.eu-central-1
    aws.eu-north-1     = aws.eu-north-1
    aws.eu-west-1      = aws.eu-west-1
    aws.eu-west-2      = aws.eu-west-2
    aws.eu-west-3      = aws.eu-west-3
    aws.sa-east-1      = aws.sa-east-1
    aws.us-east-1      = aws.us-east-1
    aws.us-east-2      = aws.us-east-2
    aws.us-west-1      = aws.us-west-1
    aws.us-west-2      = aws.us-west-2
  }
}
