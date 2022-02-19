locals {
  domain_enabled   = var.domain_name != null && var.domain_name != "" ? true : false
  domain_count     = local.domain_enabled ? 1 : 0
  create_log_group = true
  log_group_arn    = module.cloudwatch_log_group.log_group_arn
}
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
}
module "account_settings" {
  source = "cloudposse/api-gateway/aws//modules/account-settings"

  version = "0.2.0"
  name    = "api-gateway-${module.label.environment}"

}
resource "aws_api_gateway_rest_api" "main" {
  name = "api-gateway-${module.label.environment}"
  tags = merge(module.label.tags, { Name = "Api Gateway" })
}

resource "aws_api_gateway_resource" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = var.path_part
}

resource "aws_api_gateway_method" "main" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.main.id
  http_method   = "ANY"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.main.id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = var.integration_http_method
  type                    = var.integration_input_type
  uri                     = "http://${var.elastic_beanstalk_application_name}-$${stageVariables.targetEnv}.${join(".", slice(split(".", var.elastic_beanstalk_environment_cname), 1, length(split(".", var.elastic_beanstalk_environment_cname))))}/{proxy}"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
  connection_type = "VPC_LINK"
  connection_id   = aws_api_gateway_vpc_link.this.id
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  depends_on  = [aws_api_gateway_integration.main]

  variables = {
    # just to trigger redeploy on resource changes
    resources = join(", ", [aws_api_gateway_resource.main.id])

    # note: redeployment might be required with other gateway changes.
    # when necessary run `terraform taint <this resource's address>`
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = module.label.stage


  variables = {
    vpc_link_id = aws_api_gateway_vpc_link.this.id
  }

  dynamic "access_log_settings" {
    for_each = local.create_log_group ? [1] : []

    content {
      destination_arn = local.log_group_arn
      format          = replace(var.access_log_format, "\n", "")
    }
  }
}
resource "random_string" "random" {
  length  = 5
  special = false
  number  = true
  upper   = true
}

module "cloudwatch_log_group" {
  source      = "cloudposse/cloudwatch-logs/aws"
  version     = "0.6.4"
  kms_key_arn = var.kms_key_arn
  context = merge(var.context,
    {
      namespace   = "",
      stage       = "",
      environment = "",
      name        = "api-gateway-${module.label.environment}-${random_string.random.result}"
  })
}

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }

  depends_on = [
    module.account_settings
  ]
}

# Optionally create a VPC Link to allow the API Gateway to communicate with private resources (e.g. ALB)
resource "aws_api_gateway_vpc_link" "this" {
  name        = "vpc-link-${module.label.name}"
  description = "VPC Link for ${module.label.name}"
  target_arns = [var.nlb_arn]
}


resource "aws_api_gateway_base_path_mapping" "domain_mapping" {
  count       = local.domain_count
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  domain_name = aws_api_gateway_domain_name.server_domain[0].domain_name
}

resource "aws_api_gateway_domain_name" "server_domain" {
  count           = local.domain_count
  certificate_arn = var.acm_request_certificate_arn
  domain_name     = var.domain_name
  security_policy = "TLS_1_2"
}

# Example DNS record using Route53.
# Route53 is not specifically required; any DNS host can be used.
resource "aws_route53_record" "server_record" {
  count   = local.domain_count
  name    = aws_api_gateway_domain_name.server_domain[0].domain_name
  type    = "A"
  zone_id = var.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.server_domain[0].cloudfront_domain_name
    zone_id                = aws_api_gateway_domain_name.server_domain[0].cloudfront_zone_id
  }
}
