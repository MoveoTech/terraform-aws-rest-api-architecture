# VPC for ECS Fargate
module "vpc" {
  source = "./vpc"
  vpc_tag_name = "${var.platform_name}-vpc"
  number_of_private_subnets = 3
  private_subnet_tag_name = "${var.platform_name}-private-subnet"
  route_table_tag_name = "${var.platform_name}-rt"
  environment = var.environment
  security_group_lb_name = "${var.platform_name}-alb-sg"
  security_group_eb_name = "${var.platform_name}-eb-sg"
  app_port = var.app_port
  main_pvt_route_table_id = var.main_pvt_route_table_id
  availability_zones = var.availability_zones
  region = var.region
}

module "elastic_beanstalk" {
  source = "./elastic-beanstalk"
  region = var.region
  name = var.app_name
  availability_zones = var.availability_zones
  instance_type = var.instance_type
  solution_stack_name = var.solution_stack_name
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  depends_on = [
    module.vpc.aws_vpc_endpoint_sqs,
    module.vpc.aws_vpc_endpoint_cloudformation,
    module.vpc.aws_vpc_endpoint_elasticbeanstalk_health,
    module.vpc.aws_vpc_endpoint_elasticbeanstalk
    ]

}

# API Gateway and VPC link
module api_gateway {
  source = "./api-gateway"
  name = "${var.platform_name}-${var.environment}"
  integration_input_type = "HTTP_PROXY"
  path_part = "{proxy+}"
  app_port = var.app_port
  nlb_arn = module.elastic_beanstalk.load_balancers_arn
  elastic_beanstalk_environment_cname = module.elastic_beanstalk.load_balancers_arn
  environment = var.environment
  elastic_beanstalk_application_name = var.app_name
  depends_on = [module.elastic_beanstalk.elastic_beanstalk_application]
}
