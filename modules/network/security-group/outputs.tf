
output "id" {
  description = "ID's of the created security group"
  value       = aws_security_group.default.id
}