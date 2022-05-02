
output "server_url" {
  value       = module.infrastructure.server_url
  description = "The server api url"
}

output "client_url" {
  value       = module.infrastructure.client_url
  description = "The client url"
}
