
module "vpc" {
  source  = "cloudposse/vpc/aws"
  version = "0.28.1"

  cidr_block = "172.16.0.0/16"

  context = var.context
}

module "vpc_endpoints" {
  source = "../vpc-endpoints"

  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.subnets.private_subnet_ids
  private_route_table_ids = module.subnets.private_route_table_ids
  default_security_group  = module.default_security_group.id
  region                  = var.region
  context                 = var.context
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
  vpc_id  = module.vpc.vpc_id
  context = var.context
}

module "default_security_group" {
  source = "../security-group"

  vpc_id            = module.vpc.vpc_id
  vpc_cidr_block    = module.vpc.vpc_cidr_block
  s3_prefix_list_id = module.vpc_endpoints.aws_vpc_endpoint_s3
  context           = var.context
}

