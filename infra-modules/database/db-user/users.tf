module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}
resource "random_password" "db_user_password" {
  length = 16
}
# DATABASE USER
resource "mongodbatlas_database_user" "user1" {
  username           = "${module.label.name}_${module.label.stage}_user"
  password           = random_password.db_user_password.result
  project_id         = var.project_id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "${module.label.name}-${module.label.stage}"
  }
  labels {
    key   = "Name"
    value = "DB User"
  }

  scopes {
    name = mongodbatlas_cluster.cluster.name
    type = "CLUSTER"
  }
}
