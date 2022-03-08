provider "aws" {
  region = var.region
}
locals {
  domain_enabled     = var.parent_zone_id != null && var.domain_name != null
  server_domain_name = local.domain_enabled ? "${var.stage}.api.${var.domain_name}" : ""
}

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

locals {
  secrets = {
    db_username          = module.atlas_database.db_username
    db_password          = module.atlas_database.db_password
    db_connection_string = module.atlas_database.db_connection_string
  }
}

module "network" {
  source             = "./network"
  region             = var.region
  availability_zones = var.availability_zones
  context            = module.this.context
}

module "atlas_database" {
  source             = "./database"
  region             = var.region
  public_key         = var.public_key
  private_key        = var.private_key
  atlas_org_id       = var.atlas_org_id
  vpc_id             = module.network.vpc_id
  cidr_block         = module.network.vpc_cidr_block
  private_subnet_ids = module.network.private_subnet_ids
  atlas_users        = var.atlas_users
  context            = module.this.context
}

resource "aws_secretsmanager_secret" "secrets" {
  name                    = "secrets/${module.this.stage}"
  description             = "Envoironment secrets"
  recovery_window_in_days = 0
  kms_key_id              = module.server.eb_kms_id
  tags = merge(module.this.tags, {
    yor_trace = "f225cf4e-e1e9-4c5c-a479-f5d907e634f1"
  })
}

resource "aws_secretsmanager_secret_version" "secrets" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode(local.secrets)
}



module "acm_request_certificate_server" {
  source      = "./acm"
  enabled     = local.domain_enabled
  domain_name = local.server_domain_name
  zone_id     = var.parent_zone_id
}



module "cognito_auth" {
  source                      = "./authentication/cognito"
  client_logout_urls          = var.client_logout_urls
  client_default_redirect_uri = var.client_default_redirect_uri
  client_callback_urls        = var.client_callback_urls
  cognito_default_user_email  = var.cognito_default_user_email
  context                     = module.this.context
}

module "server" {
  source                        = "./backend"
  domain_name                   = local.server_domain_name
  zone_id                       = var.parent_zone_id
  acm_request_certificate_arn   = try(module.acm_request_certificate_server.acm_request_certificate_arn, "")
  region                        = var.region
  availability_zones            = var.availability_zones
  instance_type                 = var.instance_type
  vpc_id                        = module.network.vpc_id
  private_subnet_ids            = module.network.private_subnet_ids
  private_route_table_ids       = module.network.private_route_table_ids
  associated_security_group_ids = module.atlas_database.atlas_resource_sg_id
  ssm_arn                       = aws_secretsmanager_secret.secrets.arn
  depends_on                    = [module.network, module.acm_request_certificate_server, module.cognito_auth]
  user_pool_arn                 = module.cognito_auth.user_pool_arn
  context                       = module.this.context
}



module "acm_request_certificate_client" {
  source                    = "./acm"
  enabled                   = local.domain_enabled
  domain_name               = var.domain_name
  zone_id                   = var.parent_zone_id
  subject_alternative_names = var.subject_alternative_names
}


module "cloudfront_s3_cdn" {
  source              = "./client/cloudfront"
  region              = var.region
  aliases             = var.aliases_client
  dns_alias_enabled   = var.dns_alias_enabled
  parent_zone_id      = var.parent_zone_id
  acm_certificate_arn = try(module.acm_request_certificate_client.acm_request_certificate_arn, "")
  context             = module.this.context
}


module "cicd" {
  source                             = "./cicd"
  region                             = var.region
  github_secret_name                 = var.github_secret_name
  github_org                         = var.github_org
  client_repository_name             = var.client_repository_name
  client_branch_name                 = var.client_branch_name
  server_repository_name             = var.server_repository_name
  server_branch_name                 = var.server_branch_name
  elastic_beanstalk_application_name = module.server.elastic_beanstalk_application_name
  elastic_beanstalk_environment_name = module.server.elastic_beanstalk_environment_name
  client_bucket_name                 = module.cloudfront_s3_cdn.cf_s3_bucket_name
  cognito_pool_id                    = module.cognito_auth.user_pool_id
  cognito_web_client_id              = module.cognito_auth.web_client_id
  context                            = module.this.context
}


