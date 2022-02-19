
resource "mongodbatlas_privatelink_endpoint" "private_endpoint" {
  project_id    = var.project_id
  provider_name = "AWS"
  region        = var.region
}

resource "aws_vpc_endpoint" "project_vpc_endpoint" {
  vpc_id             = var.vpc_id
  service_name       = mongodbatlas_privatelink_endpoint.private_endpoint.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.private_subnet_ids
  security_group_ids = [var.security_group_id]
}

resource "mongodbatlas_privatelink_endpoint_service" "project_vpc_endpoint_svc" {
  provider_name       = "AWS"
  project_id          = var.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.private_endpoint.private_link_id
  endpoint_service_id = aws_vpc_endpoint.project_vpc_endpoint.id
}
