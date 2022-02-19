
module "network" {
  source             = "./vpc-private"

  availability_zones = var.availability_zones
  context            = var.context
  region             = var.region
}


# Most of the application you will need to use this network
# Use this vpc if you need an internet network

# module "network" {
#   source = "./vpc-private-public"

#   availability_zones = var.availability_zones
#   context            = var.context
# }



