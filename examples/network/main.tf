module "context" {
  source = "../../modules/context"
}


# Most of the application you will need to use this network
# Use this vpc if you need an internet network
module "network" {
  source             = "../../modules/network/vpc-private-public"
  region             = "eu-west-3"
  availability_zones = ["eu-west-3a"]
  context            = module.context
}
