
output "atlas_endpoint_sg_id" {
  description = "ID's of the created endpoint security group"
  value       = aws_security_group.atlas_endpoint.id
}

output "atlas_resource_sg_id" {
  description = "ID's of the created security group"
  value       = aws_security_group.atlas_resource.id
}
