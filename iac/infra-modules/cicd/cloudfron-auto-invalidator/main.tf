provider "aws" {
  region = "eu-west-3"
}
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

data "aws_caller_identity" "current" {}

data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/tmp/lambda.zip"
  source_file = "${path.module}/src/app.py"
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name_prefix        = "cloudfron-invokation-role-"
  assume_role_policy = data.aws_iam_policy_document.assume.json

  tags = module.label.tags
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "cloudfront_read" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontReadOnlyAccess"
}

data "aws_iam_policy_document" "cloudfront_invalidations" {

  statement {
    effect = "Allow"
    actions = [
      "cloudfront:CreateInvalidation"
    ]

    resources = [
      "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "cloudfront_invalidations" {
  name_prefix = "cloudfront-invalidations-"
  policy      = data.aws_iam_policy_document.cloudfront_invalidations.json
  role        = aws_iam_role.this.name
}



resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda.output_path
  function_name    = var.name
  handler          = "app.lambda_handler"
  memory_size      = var.memory_size
  role             = aws_iam_role.this.arn
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout          = var.timeout
  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.security_group_id]
  }
  tracing_config {
    mode = "Active"
  }
  tags = module.label.tags
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal     = "s3.amazonaws.com"
}
