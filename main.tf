provider "aws" {
  region = var.region
}

provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

locals {
  s3_bucket_access_log_bucket_name = module.s3_bucket_access_logs.bucket_id
  domain_enabled                   = var.parent_zone_id != null && var.domain_name != null
  server_domain_name               = local.domain_enabled ? "${var.stage}.api.${var.domain_name}" : ""
}

locals {
  secrets = {
    db_username          = module.atlas_database.db_username
    db_password          = module.atlas_database.db_password
    db_connection_string = length(module.atlas_database.db_connection_string) > 0 ? module.atlas_database.db_connection_string : module.atlas_database.connection_string_srv
  }
}
resource "aws_ebs_encryption_by_default" "default" {
  enabled = true
}

# module "network" {
#   source = "./modules/network/vpc-private"

#   availability_zones = var.availability_zones
#   region             = var.region§
#   context            = module.this.context
# }

module "s3_bucket_access_logs" {
  source  = "cloudposse/s3-log-storage/aws"
  version = "0.28.3"

  name                    = "${module.this.context.name}-${module.this.context.stage}-s3-access-logs"
  block_public_policy     = true
  allow_ssl_requests_only = true
  versioning_enabled      = true
  acl                     = "private"
  sse_algorithm           = "aws:kms"


  context = var.context
}

# Most of the application you will need to use this network
# Use this vpc if you need an internet network
module "network" {
  source             = "./modules/network/vpc-private-public"
  region             = var.region
  availability_zones = var.availability_zones
  context            = module.this.context
}

module "atlas_database" {
  source                      = "./modules/database"
  region                      = var.region
  atlas_org_id                = var.atlas_org_id
  vpc_id                      = module.network.vpc_id
  cidr_block                  = module.network.vpc_cidr_block
  private_subnet_ids          = module.network.private_subnet_ids
  atlas_whitelist_ips         = module.network.nat_gateway_public_ips
  private_endpoint_enabled    = var.private_endpoint_enabled
  atlas_users                 = var.atlas_users
  provider_instance_size_name = var.provider_instance_size_name
  enable_atlas_whitelist_ips  = var.enable_atlas_whitelist_ips
  public_key                  = var.public_key
  private_key                 = var.private_key
  context                     = module.this.context
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

module "cognito_auth" {
  source                      = "./modules/authentication/cognito"
  client_logout_urls          = var.client_logout_urls
  client_default_redirect_uri = var.client_default_redirect_uri
  client_callback_urls        = var.client_callback_urls
  cognito_default_user_email  = var.cognito_default_user_email
  context                     = module.this.context
}

module "acm_request_certificate_server" {
  source      = "./modules/acm"
  enabled     = local.domain_enabled
  domain_name = local.server_domain_name
  zone_id     = var.parent_zone_id

  providers = {
    aws = aws.east
  }
}



module "server" {
  source                           = "./modules/backend"
  autoscale_max                    = var.autoscale_max
  autoscale_min                    = var.autoscale_min
  domain_name                      = local.server_domain_name
  zone_id                          = var.parent_zone_id
  acm_request_certificate_arn      = try(module.acm_request_certificate_server.acm_request_certificate_arn, "")
  cors_domain                      = var.subject_alternative_names
  region                           = var.region
  instance_type                    = var.instance_type
  vpc_id                           = module.network.vpc_id
  private_subnet_ids               = module.network.private_subnet_ids
  associated_security_group_ids    = module.atlas_database.atlas_resource_sg_id
  env_vars                         = var.env_vars
  s3_bucket_access_log_bucket_name = local.s3_bucket_access_log_bucket_name
  extended_ec2_policy_document     = var.extended_ec2_policy_document
  cognito_enabled                  = var.cognito_enabled
  depends_on = [
    module.network,
    module.acm_request_certificate_server,
    module.cognito_auth,
    module.atlas_database

  ]

  user_pool_arn = module.cognito_auth.user_pool_arn
  context       = module.this.context
}




module "acm_request_certificate_client" {
  source                    = "./modules/acm"
  enabled                   = local.domain_enabled
  domain_name               = var.domain_name
  zone_id                   = var.parent_zone_id
  subject_alternative_names = var.subject_alternative_names
  providers = {
    aws = aws.east
  }
}


module "cloudfront_s3_cdn" {
  source                           = "./modules/client/cloudfront"
  aliases                          = var.aliases_client
  dns_alias_enabled                = var.dns_alias_enabled
  parent_zone_id                   = var.parent_zone_id
  acm_certificate_arn              = try(module.acm_request_certificate_client.acm_request_certificate_arn, "")
  s3_bucket_access_log_bucket_name = local.s3_bucket_access_log_bucket_name
  context                          = module.this.context
}


module "cicd" {
  source                             = "./modules/cicd"
  github_org                         = var.github_org
  client_env_prefix                  = var.client_env_prefix
  client_repository_name             = var.client_repository_name
  client_branch_name                 = var.client_branch_name
  client_buildspec_path              = var.client_buildspec_path
  server_buildspec_path              = var.server_buildspec_path
  server_repository_name             = var.server_repository_name
  server_branch_name                 = var.server_branch_name
  elastic_beanstalk_application_name = module.server.elastic_beanstalk_application_name
  elastic_beanstalk_environment_name = module.server.elastic_beanstalk_environment_name
  client_bucket_name                 = module.cloudfront_s3_cdn.s3_bucket
  cognito_pool_id                    = module.cognito_auth.user_pool_id
  cognito_web_client_id              = module.cognito_auth.web_client_id
  cf_distribution_id                 = module.cloudfront_s3_cdn.cf_id
  invoke_url                         = module.server.invoke_url
  private_subnet_ids                 = module.network.private_subnet_ids
  vpc_id                             = module.network.vpc_id
  region                             = var.region
  s3_bucket_access_log_bucket_name   = local.s3_bucket_access_log_bucket_name
  codebuild_server_env_vars          = var.codebuild_server_env_vars
  codebuild_client_env_vars          = var.codebuild_client_env_vars
  context                            = module.this.context
}

