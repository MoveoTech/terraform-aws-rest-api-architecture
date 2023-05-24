output "function_arn" {
  description = "ARN's of the created lambda function"
  value       = aws_lambda_function.this.arn
}
output "function_name" {
  description = "Lambda function name"
  value       = var.name
}
