output "function_arn" {
  value = aws_lambda_function.this.arn
}
output "function_name" {
  value = var.name
}
