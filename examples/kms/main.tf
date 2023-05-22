provider "aws" {
  region = "us-east-1"
}


module "kms" {
  source = "../../modules/kms"
  region = "us-east-1"
}

