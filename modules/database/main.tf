
module "atlas_vpc_endpoint" {
  source = "./vpc-endpoint"
  count  = var.private_endpoint_enabled ? 1 : 0

  project_id         = module.atlas_project.atlas_project_id
  region             = var.region
  private_subnet_ids = var.private_subnet_ids
  vpc_id             = var.vpc_id
  security_group_id  = module.security_groups.atlas_endpoint_sg_id
}

resource "mongodbatlas_auditing" "audit" {
  project_id                  = module.atlas_project.atlas_project_id
  audit_filter                = "{ 'atype': 'authenticate', 'param': {   'user': 'auditAdmin',   'db': 'admin',   'mechanism': 'SCRAM-SHA-1' }}"
  audit_authorization_success = false
  enabled                     = true
}

resource "mongodbatlas_project_ip_access_list" "ip" {
  for_each = { for ip in var.atlas_whitelist_ips : ip => ip }

  project_id = module.atlas_project.atlas_project_id
  ip_address = each.value
  comment    = "IP Address for accessing the cluster"
}

# resource "mongodbatlas_org_invitation" "invitation" {
#   for_each = { for vm in var.atlas_users : vm => vm }
#   username = each.value
#   org_id   = var.atlas_org_id
#   roles    = ["ORG_MEMBER"]
# }
resource "mongodbatlas_project_invitation" "project_invitation" {
  for_each   = { for vm in var.atlas_users : vm => vm }
  username   = each.value
  project_id = module.atlas_project.atlas_project_id
  roles      = ["GROUP_DATA_ACCESS_READ_WRITE"]
}

module "atlas_project" {
  source       = "./atlas-project"
  atlas_org_id = var.atlas_org_id
  context      = var.context
}

module "db_users" {
  source       = "./db-user"
  cluster_name = module.atlas_cluster.cluster_name
  project_id   = module.atlas_project.atlas_project_id
  context      = var.context
}

module "security_groups" {
  source     = "./security-groups"
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  context = var.context
}

module "atlas_cluster" {
  source           = "./atlas-cluster"
  region           = var.region
  atlas_project_id = module.atlas_project.atlas_project_id


  depends_on = [module.atlas_vpc_endpoint]
  context    = var.context

}
