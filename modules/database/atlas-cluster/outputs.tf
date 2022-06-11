output "connection_string" {
  value       = try(mongodbatlas_cluster.cluster-atlas.connection_strings[0].private_endpoint[0].srv_connection_string, "")
  description = "The private endpoint-aware cluster connection string"
}
output "connection_string_srv" {
  value       = try(mongodbatlas_cluster.cluster-atlas.connection_strings[0].standard_srv, "")
  description = "The srv connection string. Example return string: standard_srv = `mongodb+srv://cluster-atlas.ygo1m.mongodb.net`"
}

output "cluster_name" {
  value       = mongodbatlas_cluster.cluster-atlas.name
  description = "Database cluster name"
}
