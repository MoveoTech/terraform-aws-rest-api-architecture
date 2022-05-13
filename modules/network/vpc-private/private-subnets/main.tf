
data "aws_availability_zones" "available" {
  count = local.enabled_count
}
locals {
  availability_zones_count = local.enabled ? length(var.availability_zones) : 0
  enabled                  = true
  enabled_count            = local.enabled ? 1 : 0
  delimiter                = "-"
}

module "utils" {
  source  = "cloudposse/utils/aws"
  version = "0.8.1"
}

data "aws_vpc" "default" {
  count = local.enabled ? 1 : 0
  id    = var.vpc_id
}

locals {
  map_map = {
    short = "to_short"
    fixed = "to_fixed"
    full  = "identity"
  }
  az_map = module.utils.region_az_alt_code_maps[local.map_map[var.availability_zone_attribute_style]]
}

module "private_label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  attributes = ["private"]
  tags = merge(
    var.private_subnets_additional_tags,
    { (var.subnet_type_tag_key) = format(var.subnet_type_tag_value_format, "private") }
  )
}

locals {
  private_subnet_count        = var.max_subnet_count == 0 ? length(flatten(data.aws_availability_zones.available.*.names)) : var.max_subnet_count
  private_network_acl_enabled = signum(length(var.private_network_acl_id)) == 0 ? 1 : 0
}

resource "aws_subnet" "private" {
  count             = local.enabled ? local.availability_zones_count : 0
  vpc_id            = var.vpc_id
  availability_zone = element(var.availability_zones, count.index)

  cidr_block = cidrsubnet(
    signum(length(var.cidr_block)) == 1 ? var.cidr_block : join("", data.aws_vpc.default.*.cidr_block),
    ceil(log(local.private_subnet_count * 2, 2)),
    count.index
  )

  tags = merge(
    module.private_label.tags,
    {
      "Name" = format("%s%s%s", module.private_label.id, local.delimiter, local.az_map[element(var.availability_zones, count.index)])
    }
    , {
      yor_trace = "12ce2903-1bcc-4b02-92ea-0546e65c5140"
  })

  lifecycle {
    # Ignore tags added by kops or kubernetes
    ignore_changes = [tags.kubernetes, tags.SubnetType]
  }
}

resource "aws_route_table" "private" {
  count  = local.enabled ? local.availability_zones_count : 0
  vpc_id = var.vpc_id

  tags = merge(
    module.private_label.tags,
    {
      "Name" = format("%s%s%s", module.private_label.id, local.delimiter, local.az_map[element(var.availability_zones, count.index)])
    }
    , {
      yor_trace = "357cf0c5-ab28-4143-ad88-328c9c9712f1"
  })
}

resource "aws_route_table_association" "private" {
  count          = local.enabled ? local.availability_zones_count : 0
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_network_acl" "private" {
  count      = local.enabled ? local.private_network_acl_enabled : 0
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.private.*.id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(module.private_label.tags, {
    yor_trace = "425d9733-b10e-442d-8c26-2d561bc3f028"
  })
}
