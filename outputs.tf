
output "server_url" {
  value       = module.server.invoke_url
  description = "Server api url "
}

output "client_url" {
  value       = module.cloudfront_s3_cdn.client_url
  description = "Client url "
}
