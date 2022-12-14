output "arn" {
  value       = aws_amplify_app.app_name.arn
  description = "ARN of the Amplify app."
}

output "default_domain" {
  value       = aws_amplify_app.app_name.default_domain
  description = "Default domain for the Amplify app."
}

output "id" {
  value       = aws_amplify_app.app_name.id
  description = "unique ID of the Amplify app."
}

output "production_branch" {
  value       = aws_amplify_app.app_name.production_branch
  description = "Describes the information about a production branch for an Amplify app."
}
