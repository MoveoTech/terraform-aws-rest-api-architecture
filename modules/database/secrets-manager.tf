locals {
  count = (var.enable_database_credentials_secret_manager && var.elastic_beanstalk_kms_id != null) ? 1 : 0
  secrets = {
    db_username          = module.db_users.user_db
    db_password          = module.db_users.user_db_pass
    db_connection_string = length(module.atlas_cluster.connection_string) > 0 ? module.atlas_cluster.connection_string : module.atlas_cluster.connection_string_srv
  }
}
resource "aws_secretsmanager_secret" "secrets" {
  count                   = local.count
  name                    = "secrets/${var.context.stage}"
  description             = "Envoironment secrets"
  recovery_window_in_days = 0
  kms_key_id              = var.elastic_beanstalk_kms_id
  tags = merge(var.context.tags, {
    yor_trace = "f225cf4e-e1e9-4c5c-a479-f5d907e634f1"
  })
}


resource "aws_secretsmanager_secret_version" "secrets" {
  count         = local.count
  secret_id     = aws_secretsmanager_secret.secrets[0].id
  secret_string = jsonencode(local.secrets)
}
