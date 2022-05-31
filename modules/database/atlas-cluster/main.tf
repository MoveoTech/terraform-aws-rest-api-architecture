
resource "mongodbatlas_cluster" "cluster-atlas" {
  project_id                   = var.atlas_project_id
  name                         = var.context.name
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  cluster_type                 = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = upper(replace(var.region, "-", "_")) # e.g. eu-west-1 => EU_WEST_1
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  # Provider settings
  provider_name               = "AWS"
  disk_size_gb                = 10
  provider_instance_size_name = var.provider_instance_size_name
}


