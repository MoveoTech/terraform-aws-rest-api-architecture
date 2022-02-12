output "connection_string" {
  value = mongodbatlas_cluster.cluster-atlas.connection_strings[0].private_endpoint[0].srv_connection_string
  description = "The private endpoint-aware cluster connection string"
}

output "cluster_name" {
  value = mongodbatlas_cluster.cluster-atlas.name
}
