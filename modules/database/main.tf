
provider "mongodbatlas" {
  public_key  = local.public_key
  private_key = local.private_key
}

locals {
  public_key   = var.public_key != null ? var.public_key : jsondecode(data.aws_secretsmanager_secret_version.database_tokens.secret_string)["PublicKey"]
  private_key  = var.private_key != null ? var.private_key : jsondecode(data.aws_secretsmanager_secret_version.database_tokens.secret_string)["PrivateKey"]
  atlas_org_id = jsondecode(data.aws_secretsmanager_secret_version.database_tokens.secret_string)["OrganizationID"]
}

data "aws_secretsmanager_secret" "database_secrets" {
  name = "database"
}

data "aws_secretsmanager_secret_version" "database_tokens" {
  secret_id = data.aws_secretsmanager_secret.database_secrets.id
}

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
  count = var.enable_atlas_whitelist_ips ? 1 : 0

  project_id = module.atlas_project.atlas_project_id
  ip_address = one(var.atlas_whitelist_ips)
  comment    = "AWS NAT gateway ip address for accessing the cluster"
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
  atlas_org_id = local.atlas_org_id
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
  source                      = "./atlas-cluster"
  region                      = var.region
  atlas_project_id            = module.atlas_project.atlas_project_id
  provider_instance_size_name = var.provider_instance_size_name
  depends_on                  = [module.atlas_vpc_endpoint]
  context                     = var.context

}

