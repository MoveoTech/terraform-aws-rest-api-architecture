output "user_pool_arn" {
  description = "The ARN of the REST API"
  value       = module.aws_cognito_user_pool.arn
}
output "user_pool_id" {
  description = "The user pool id"
  value       = module.aws_cognito_user_pool.id
}
output "web_client_id" {
  description = "The web client id"
  value       = module.aws_cognito_user_pool.client_ids[0]
}
