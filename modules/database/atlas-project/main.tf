
resource "mongodbatlas_project" "project" {
  name   = "${var.context.name}-${var.context.stage}"
  org_id = var.atlas_org_id
  teams {
    team_id    = var.team_id
    role_names = var.role_names
  }
}
