output "db_connection_string" {
  value       = module.atlas_cluster.connection_string
  description = "The private endpoint-aware cluster connection string"
}
output "connection_string_srv" {
  value       = module.atlas_cluster.connection_string_srv
  description = "The srv connection string. Example return string: standard_srv = `mongodb+srv://cluster-atlas.ygo1m.mongodb.net`"
}
output "db_username" {
  value       = module.db_users.user_db
  description = "The username of the account with which to access the database"
}

output "db_password" {
  value       = module.db_users.user_db_pass
  description = "The password of the account with which to access the database"
}

output "atlas_resource_sg_id" {
  description = "ID's of the created security group"
  value       = module.security_groups.atlas_resource_sg_id
}
output "atlas_project_id" {
  description = "ID's of the created cluster project"
  value       = module.atlas_project.atlas_project_id
}
