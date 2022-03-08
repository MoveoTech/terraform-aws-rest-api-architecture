terraform {
  required_version = ">= 0.13.0"
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    }
    aws = {
      source  = "hashicorp/aws"
    version = ">= 3.0"
    }
  }
}

