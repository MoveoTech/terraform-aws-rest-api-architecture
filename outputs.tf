
output "server_url" {
  value       = module.server.invoke_url
  description = "Server api url "
}

output "client_url" {
  value       = module.cloudfront_s3_cdn.client_url
  description = "Client url "
}

output "atlas_project_id" {
  description = "ID's of the created cluster project"
  value       = module.atlas_database.atlas_project_id
}
output "atlas_x509_user" {
  description = "user x509"
  value       = module.atlas_database.db_user_x509
}