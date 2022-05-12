
output "server_url" {
  value       = module.server.invoke_url
  description = "The server api url"
}

output "client_url" {
  value       = module.cloudfront_s3_cdn.client_url
  description = "The client url"
}
