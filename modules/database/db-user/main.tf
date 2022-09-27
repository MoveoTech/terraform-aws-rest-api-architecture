
resource "random_password" "db_user_password" {
  length = 24
}
# DATABASE USER
resource "mongodbatlas_database_user" "user1" {
  username = "${var.context.name}_${var.context.stage}_user"
  # password           = random_password.db_user_password.result
  project_id         = var.project_id
  # auth_database_name = "admin"
  x509_type          = "MANAGED"
  auth_database_name      = "$external"

  roles {
    role_name     = "atlasAdmin"
    database_name = "admin"
  }
  # roles {
  #   role_name     = "readWrite"
  #   database_name = "${var.context.name}-${var.context.stage}"
  # }
  labels {
    key   = "Name"
    value = "DB User"
  }

  scopes {
    name = var.cluster_name
    type = "CLUSTER"
  }
}

resource "mongodbatlas_x509_authentication_database_user" "test" {
  project_id              = mongodbatlas_database_user.user1.project_id
  username                = mongodbatlas_database_user.user1.username
  months_until_expiration = 2
  depends_on = [
    mongodbatlas_database_user.user1
  ]
}

data "mongodbatlas_x509_authentication_database_user" "test" {
  project_id = mongodbatlas_x509_authentication_database_user.test.project_id
  username   = mongodbatlas_x509_authentication_database_user.test.username
}
