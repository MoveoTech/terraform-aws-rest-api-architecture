data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
resource "aws_iam_user" "admin" {
  name = "admin-${var.context.name}"
}

module "secure_baseline" {
  source = "nozaq/secure-baseline/aws"
  version = "2.1.0"
  audit_log_bucket_name           = var.audit_s3_bucket_name
  aws_account_id                  = data.aws_caller_identity.current.account_id
  region                          = data.aws_region.current.name
  support_iam_role_principal_arns = [aws_iam_user.admin.arn]

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

