
resource "random_password" "db_user_password" {
  length = 24
}

locals {
  database_name     = "${var.context.name}-${var.context.stage}"
  database_user     = "${var.context.name}-${var.context.stage}-user"
  database_password = random_password.db_user_password.result

}

resource "random_string" "random" {
  length  = 3
  special = false
  numeric  = true
  upper   = false
}

module "rds_instance" {
    source = "cloudposse/rds/aws"
    version             = "0.40.0"
    database_name       = local.database_name
    database_user       = local.database_user
    database_password    = local.database_password
    database_port        = var.database_port
    multi_az             = var.multi_az
    storage_type         = var.storage_type
    allocated_storage    = var.allocated_storage
    storage_encrypted    = var.storage_encrypted
    engine               = var.engine
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    db_parameter_group   = var.db_parameter_group
    publicly_accessible  = var.publicly_accessible
    vpc_id               = var.vpc_id
    subnet_ids           = var.private_subnet_ids
    security_group_ids   = var.security_group_ids
    apply_immediately    = var.apply_immediately 

    context = var.context

}