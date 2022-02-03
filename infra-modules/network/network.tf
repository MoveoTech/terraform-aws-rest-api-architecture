provider "aws" {
  region = var.region
}

module "private_netwotk" {
 source               = "./vpc-private"
 stage                = var.stage  
 name                 = var.name
 availability_zones   = var.availability_zones  
 context              = module.this.context
 region              = var.region
}




# module "private_public_netwotk" {
#  source     = "./vpc-private-public"
 
#  availability_zones   = var.availability_zones  
#  context = module.this.context
# }



