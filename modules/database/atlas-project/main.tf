
resource "mongodbatlas_project" "project" {
  count = var.team_id ? 1 : 0
  name   = "${var.context.name}-${var.context.stage}"
  org_id = var.atlas_org_id
  teams {
    team_id    = var.team_id
    role_names = var.role_names
  }
}


resource "mongodbatlas_project" "project" {
  count = var.team_id ? 0 : 1
  name   = "${var.context.name}-${var.context.stage}"
  org_id = var.atlas_org_id
}