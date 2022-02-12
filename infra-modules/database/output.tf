output "db_connection_string" {
  value       = module.atlas-cluster.connection_string
  description = "The private endpoint-aware cluster connection string"
}

output "atlas_resource_sg_id" {
  value = module.security_groups.atlas_resource_sg_id
}
