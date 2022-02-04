
provider "aws" {
  region = var.region
}

module "network" {
  source             = "./network"
  region             = var.region
  availability_zones = var.availability_zones
  context            = module.this.context
}

module "server" {
  source = "./backend"

  region                  = var.region
  app_name                = var.app_name
  availability_zones      = var.availability_zones
  instance_type           = var.instance_type
  solution_stack_name     = var.solution_stack_name
  vpc_id                  = module.network.vpc_id
  app_port                = var.app_port
  private_subnet_ids      = module.network.private_subnet_ids
  private_route_table_ids = module.network.private_route_table_ids
  platform_name = var.platform_name

  depends_on = [module.network]
  context    = module.this.context
}
