provider "aws" {
  region = "us-east-1"
}


module "rds" {
  source             = "../../../modules/rds"
  engine             = "engine"
  engine_version     = "engine_version"
  instance_class     = "instance_class"
  db_parameter_group = "db_parameter_group"
  vpc_id             = "vpc_id"
  private_subnet_ids = ["private_subnet_ids"]
}

