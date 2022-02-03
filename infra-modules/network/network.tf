provider "aws" {
  region = var.region
}

# module "private_netwotk" {
#  source               = "./vpc-private"
#  stage                = var.stage  
#  name                 = var.name
#  availability_zones   = var.availability_zones  
#  context              = module.this.context
#  region              = var.region
# }


# Most of the application you will need to use this network
# Use this vpc if you need an internet network

module "private_public_netwotk" {
 source     = "./vpc-private-public"
 
 availability_zones   = var.availability_zones  
 context = module.this.context
}



