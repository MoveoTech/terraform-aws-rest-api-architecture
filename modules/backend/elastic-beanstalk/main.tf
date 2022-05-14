
module "elastic_beanstalk_application" {
  source      = "cloudposse/elastic-beanstalk-application/aws"
  version     = "0.11.1"
  description = "Elastic Beanstalk application"
  context     = var.context
}

module "elastic_beanstalk_environment" {
  source  = "cloudposse/elastic-beanstalk-environment/aws"
  version = "0.46.0"

  description                        = var.description
  region                             = var.region
  availability_zone_selector         = var.availability_zone_selector
  dns_zone_id                        = var.dns_zone_id
  associated_security_group_ids      = [var.associated_security_group_ids]
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

  autoscale_min             = var.autoscale_min
  autoscale_max             = var.autoscale_max
  autoscale_measure_name    = var.autoscale_measure_name
  autoscale_statistic       = var.autoscale_statistic
  autoscale_unit            = var.autoscale_unit
  autoscale_lower_bound     = var.autoscale_lower_bound
  autoscale_lower_increment = var.autoscale_lower_increment
  autoscale_upper_bound     = var.autoscale_upper_bound
  autoscale_upper_increment = var.autoscale_upper_increment

  vpc_id               = var.vpc_id
  loadbalancer_subnets = var.private_subnet_ids
  application_subnets  = var.private_subnet_ids

  allow_all_egress = true


  rolling_update_enabled  = var.rolling_update_enabled
  rolling_update_type     = var.rolling_update_type
  updating_min_in_service = var.updating_min_in_service
  updating_max_batch      = var.updating_max_batch

  application_port = var.application_port

  # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.solution_stack_name.name

  additional_settings = var.additional_settings
  env_vars = {
    "REGION"        = var.region
    "NODE_ENV"      = "${var.context.stage}"
    "DATABASE_NAME" = "${var.context.name}-${var.context.stage}"
  }
  enable_stream_logs           = true
  extended_ec2_policy_document = data.aws_iam_policy_document.minimal_s3_permissions.json
  prefer_legacy_ssm_policy     = false
  prefer_legacy_service_policy = false
  s3_bucket_encryption_enabled = true
  s3_bucket_versioning_enabled = true
  managed_actions_enabled      = true
  # Unhealthy threshold count and healthy threshold count must be the same for Network Load Balancers
  healthcheck_healthy_threshold_count   = 3
  healthcheck_unhealthy_threshold_count = 3

  # Health check interval must be either 10 seconds or 30 seconds for Network Load Balancers
  healthcheck_interval = 30

  context = var.context
}

data "aws_iam_policy_document" "minimal_s3_permissions" {
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


