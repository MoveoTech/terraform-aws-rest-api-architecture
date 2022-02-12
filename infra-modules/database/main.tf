terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
    }

    random = {
      source  = "hashicorp/random"
    }
  }
}

module "atlas_vpc_endpoint" {
  source = "./vpc-endpoint"

  project_id         = module.atlas_project.atlas_project_id
  region             = var.region
  private_subnet_ids = var.private_subnet_ids
  vpc_id             = var.vpc_id
  security_group_id  = module.security_groups.atlas_endpoint_sg_id

  context = var.context
}

module "atlas_project" {
  source       = "./atlas-project"
  atlas_org_id = var.atlas_org_id
  context      = var.context
}

module "db_users" {
  source = "./db-user"

  project_id = module.atlas_project.atlas_project_id
  context    = var.context
}

module "security_groups" {
  source     = "./security-groups"
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  context = var.context
}

module "atlas_cluster" {
  source           = "./atlas-cluster"
  region           = var.region
  atlas_project_id = module.atlas_project.atlas_project_id


  depends_on = [module.atlas_vpc_endpoint]
  context    = var.context

}
