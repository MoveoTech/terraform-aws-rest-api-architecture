output "vpc_id" {
  description = "IDs of the created vpc"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR blocks of the created private subnets"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the created public subnets"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the created private subnets"
  value       = module.subnets.private_subnet_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.subnets.private_route_table_ids
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.subnets.public_route_table_ids
}


output "public_subnet_cidrs" {
  description = "CIDR blocks of the created public subnets"
  value       = module.subnets.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  description = "CIDR blocks of the created private subnets"
  value       = module.subnets.private_subnet_cidrs
}

output "nat_gateway_public_ips" {
  description = "	EIP of the NAT Gateway"
  value       = module.subnets.nat_gateway_public_ips
}
