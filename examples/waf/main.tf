provider "aws" {
  region = "us-east-1"
}


module "waf" {
  source      = "../../modules/waf"
  kms_key_arn = "kms_key_arn"
  type        = "type"
}

