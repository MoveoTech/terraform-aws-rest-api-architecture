
output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_cidr_block"{
   value = module.network.vpc_cidr_block
}
output "private_subnet_ids"{
   value = module.network.private_subnet_ids
}
output "private_route_table_ids"{
   value = module.network.private_route_table_ids
}