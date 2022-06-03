resource "mongodbatlas_cloud_provider_access" "default" {
  project_id    = var.project_id
  provider_name = "AWS"
  #after first apply, add the following line:
  #iam_assumed_role_arn = aws_iam_role.test_role.arn
}

resource "aws_iam_role_policy" "default_policy" {
  name = "test_policy"
  role = aws_iam_role.default_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
		"Action": "*",
		"Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "default_role" {
  name = "test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${mongodbatlas_cloud_provider_access.default.atlas_aws_account_arn}"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${mongodbatlas_cloud_provider_access.default.atlas_assumed_role_external_id}"
        }
      }
    }
  ]
}
EOF
}

module "kms" {
  source                  = "../../kms"
  region                  = var.atlas_region
  alias_name              = "mongodb-encryption-at-rest-${var.context.stage}"
  deletion_window_in_days = 30
  context                 = var.context
}

resource "mongodbatlas_encryption_at_rest" "default" {
  project_id = var.project_id

  aws_kms_config {
    enabled                = true
    customer_master_key_id = module.kms.key_id
    region                 = upper(replace(var.atlas_region, "-", "_")) # e.g. eu-west-1 => EU_WEST_1
    role_id                = mongodbatlas_cloud_provider_access.default.role_id
  }
}
