
resource "mongodbatlas_project" "project" {
  name   = "${var.context.name}-${var.context.stage}"
  org_id = var.atlas_org_id
}