module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}

resource "mongodbatlas_project" "project" {
  name   = "${module.label.name}-${module.label.stage}"
  org_id = var.atlas_org_id
}