
output "atlas_endpoint_sg_id" {
  value = aws_security_group.atlas_endpoint.id
}

output "atlas_resource_sg_id" {
  value = aws_security_group.atlas_resource.id
}
