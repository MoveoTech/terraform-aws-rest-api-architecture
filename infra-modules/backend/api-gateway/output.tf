output "arn" {
  description = "The ARN of the REST API"
  value       = aws_api_gateway_stage.main.arn
}