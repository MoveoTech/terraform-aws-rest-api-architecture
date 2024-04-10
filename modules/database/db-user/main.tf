locals{
  database_name_for_specific_privileges = "${var.db_name_for_specific_privileges_permission != null ? var.db_name_for_specific_privileges_permission : "${var.context.name}-${var.context.stage}"}"
}

resource "random_password" "db_user_password" {
  length = 24
}
# DATABASE USER
resource "mongodbatlas_database_user" "user1" {
  username           = "${var.context.name}_${var.context.stage}_user"
  password           = random_password.db_user_password.result
  project_id         = var.project_id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = local.database_name_for_specific_privileges
  }
  labels {
    key   = "Name"
    value = "DB User"
  }

  scopes {
    name = var.cluster_name
    type = "CLUSTER"
  }
}
