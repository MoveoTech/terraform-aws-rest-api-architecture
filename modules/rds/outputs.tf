output "instance_id" {
  value       = module.rds_instance.instance_id
  description = "ID of the instance"
}

output "instance_address" {
  value       = module.rds_instance.instance_address
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = module.rds_instance.instance_endpoint
  description = "DNS Endpoint of the instance"
}

output "database_name" {
  value       = local.database_name
  description = "Database name"
}
output "database_user" {
  value       = local.database_user
  description = "Database username"
}
