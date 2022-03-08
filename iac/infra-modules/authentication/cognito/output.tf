output "user_pool_arn" {
  description = "The ARN of the REST API"
  value       = module.aws_cognito_user_pool.arn
}