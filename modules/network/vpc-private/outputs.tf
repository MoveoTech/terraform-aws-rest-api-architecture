output "vpc_id" {
  description = "vpc id"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR blocks of the created private subnets"
  value       = module.vpc.vpc_cidr_block
}


output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = module.private_subnets.private_subnet_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.private_subnets.private_route_table_ids
}
