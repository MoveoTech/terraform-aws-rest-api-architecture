
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.28.1"

  cidr_block = "172.16.0.0/16"

  context = var.context
}

module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "0.39.8"

  availability_zones   = var.availability_zones
  vpc_id               = module.vpc.vpc_id
  igw_id               = module.vpc.igw_id
  cidr_block           = module.vpc.vpc_cidr_block
  nat_gateway_enabled  = true
  nat_instance_enabled = false

  context = var.context
}

module "flow_logs" {
    source  = "../vpc-flow-logs-s3-bucket"
    vpc_id = module.vpc.vpc_id
    context = var.context
}