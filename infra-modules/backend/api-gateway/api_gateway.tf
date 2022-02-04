
module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = var.context
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
  stage_name  = "${module.label.environment}-env"
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



