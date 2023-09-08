data "aws_caller_identity" "current" {}
module "elastic_beanstalk_application" {
  source      = "cloudposse/elastic-beanstalk-application/aws"
  version     = "0.11.1"
  description = "Elastic Beanstalk application"
  context     = var.context
}

module "elastic_beanstalk_environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.51.2"

  description                        = var.description
  region                             = var.region
  availability_zone_selector         = var.availability_zone_selector
  dns_zone_id                        = var.dns_zone_id
  associated_security_group_ids      = var.associated_security_group_ids
  wait_for_ready_timeout             = var.wait_for_ready_timeout
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
  environment_type                   = var.environment_type
  loadbalancer_type                  = var.loadbalancer_type
  elb_scheme                         = var.elb_scheme
  tier                               = var.tier
  version_label                      = var.version_label
  force_destroy                      = var.force_destroy

  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size
  root_volume_type = var.root_volume_type

  autoscale_min               = var.autoscale_min
  autoscale_max               = var.autoscale_max
  autoscale_measure_name      = var.autoscale_measure_name
  autoscale_statistic         = var.autoscale_statistic
  autoscale_unit              = var.autoscale_unit
  autoscale_lower_bound       = var.autoscale_lower_bound
  autoscale_lower_increment   = var.autoscale_lower_increment
  autoscale_upper_bound       = var.autoscale_upper_bound
  autoscale_upper_increment   = var.autoscale_upper_increment
  associate_public_ip_address = var.associate_public_ip_address
  vpc_id                      = var.vpc_id
  loadbalancer_subnets        = length(var.loadbalancer_subnets) > 0 ? var.loadbalancer_subnets : var.private_subnet_ids
  application_subnets         = length(var.application_subnets) > 0 ? var.application_subnets : var.private_subnet_ids

  allow_all_egress = true


  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  application_port = var.application_port

  # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.solution_stack_name.name

  additional_settings = var.additional_settings
  env_vars = merge({
    "REGION"        = var.region
    "NODE_ENV"      = var.context.stage
    "DATABASE_NAME" = "${var.context.name}-${var.context.stage}"
  }, var.env_vars)
  enable_stream_logs               = true
  extended_ec2_policy_document     = data.aws_iam_policy_document.extended.json
  prefer_legacy_ssm_policy         = false
  prefer_legacy_service_policy     = false
  s3_bucket_encryption_enabled     = true
  s3_bucket_versioning_enabled     = true
  managed_actions_enabled          = true
  s3_bucket_access_log_bucket_name = var.s3_bucket_access_log_bucket_name
  # Unhealthy threshold count and healthy threshold count must be the same for Network Load Balancers
  healthcheck_healthy_threshold_count   = 3
  healthcheck_unhealthy_threshold_count = 3

  # Health check interval must be either 10 seconds or 30 seconds for Network Load Balancers
  healthcheck_interval = 30
  depends_on = [
    data.aws_iam_policy_document.extended
  ]
  context = var.context
}

data "aws_iam_policy_document" "minimal_s3_permissions" {

  statement {
    sid = "AllowCognitoReadWritePermissions"
    actions = [
      "cognito-idp:UpdateAuthEventFeedback",
      "cognito-idp:AdminCreateUser",
      "cognito-idp:ListIdentityProviders",
      "cognito-idp:DisassociateWebACL",
      "cognito-idp:CreateUserImportJob",
      "cognito-idp:GetIdentityProviderByIdentifier",
      "cognito-idp:AdminSetUserSettings",
      "cognito-idp:AdminLinkProviderForUser",
      "cognito-idp:CreateIdentityProvider",
      "cognito-idp:DeleteUserPoolDomain",
      "cognito-idp:AdminConfirmSignUp",
      "cognito-idp:ListUsersInGroup",
      "cognito-idp:DescribeUserPool",
      "cognito-idp:AdminListUserAuthEvents",
      "cognito-idp:ListResourceServers",
      "cognito-idp:AdminListDevices",
      "cognito-idp:GetWebACLForResource",
      "cognito-idp:AdminDisableUser",
      "cognito-idp:AdminRemoveUserFromGroup",
      "cognito-idp:DeleteGroup",
      "cognito-idp:AdminDeleteUserAttributes",
      "cognito-idp:GetSigningCertificate",
      "cognito-idp:UpdateResourceServer",
      "cognito-idp:SetUICustomization",
      "cognito-idp:DeleteResourceServer",
      "cognito-idp:SetRiskConfiguration",
      "cognito-idp:GetCSVHeader",
      "cognito-idp:DeleteUserPoolClient",
      "cognito-idp:UpdateUserPoolClient",
      "cognito-idp:StartUserImportJob",
      "cognito-idp:AdminSetUserPassword",
      "cognito-idp:GetGroup",
      "cognito-idp:DescribeRiskConfiguration",
      "cognito-idp:AdminUpdateUserAttributes",
      "cognito-idp:CreateResourceServer",
      "cognito-idp:ListResourcesForWebACL",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:AdminListGroupsForUser",
      "cognito-idp:ListUsers",
      "cognito-idp:AdminGetDevice",
      "cognito-idp:UpdateUserPoolDomain",
      "cognito-idp:AdminUserGlobalSignOut",
      "cognito-idp:DeleteUserPool",
      "cognito-idp:AddCustomAttributes",
      "cognito-idp:CreateGroup",
      "cognito-idp:AdminForgetDevice",
      "cognito-idp:AdminAddUserToGroup",
      "cognito-idp:AdminRespondToAuthChallenge",
      "cognito-idp:UpdateIdentityProvider",
      "cognito-idp:GetUICustomization",
      "cognito-idp:AdminGetUser",
      "cognito-idp:ListUserPoolClients",
      "cognito-idp:CreateUserPoolDomain",
      "cognito-idp:AdminEnableUser",
      "cognito-idp:ListGroups",
      "cognito-idp:DescribeIdentityProvider",
      "cognito-idp:AdminUpdateDeviceStatus",
      "cognito-idp:UpdateGroup",
      "cognito-idp:DescribeResourceServer",
      "cognito-idp:StopUserImportJob",
      "cognito-idp:DescribeUserImportJob",
      "cognito-idp:AdminUpdateAuthEventFeedback",
      "cognito-idp:DescribeUserPoolClient",
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminDeleteUser",
      "cognito-idp:DeleteIdentityProvider",
      "cognito-idp:AdminSetUserMFAPreference",
      "logs:DeleteLogGroup",
      "cognito-idp:ListTagsForResource",
      "cognito-idp:GetUserPoolMfaConfig",
      "cognito-idp:AdminDisableProviderForUser",
      "cognito-idp:SetUserPoolMfaConfig",
      "cognito-idp:AssociateWebACL",
      "cognito-idp:UpdateUserPool",
      "cognito-idp:AdminResetUserPassword",
      "cognito-idp:ListUserImportJobs",
    ]
    resources = [
      "arn:aws:logs:*:*:log-group:/aws/elasticbeanstalk*",
      "arn:aws:cognito-idp:*:${data.aws_caller_identity.current.account_id}:userpool/*",
      "arn:aws:wafv2:*:${data.aws_caller_identity.current.account_id}:*/webacl/*/*"
    ]
  }

  statement {
    sid = "AllowS3Access"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowLambdaInvoke"
    actions = [
      "lambda:InvokeFunction",
      "lambda:GetFunction"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowS3OperationsOnElasticBeanstalkBuckets"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation"
    ]
    resources = ["*"]
  }
  statement {
    sid = "AllowSSMOperationsOnElasticBeanstalkBuckets"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:GetRandomPassword",
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "extended" {
  source_json   = join("", data.aws_iam_policy_document.minimal_s3_permissions[*].json)
  override_json = var.extended_ec2_policy_document
}


