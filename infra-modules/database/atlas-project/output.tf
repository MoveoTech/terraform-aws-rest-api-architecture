output "atlas_project_id" {
  description = "Atlas database prodect ID"
  value = module.mongodbatlas_project.project.id
}
