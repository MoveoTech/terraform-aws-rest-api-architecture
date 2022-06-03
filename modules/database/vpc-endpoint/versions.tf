terraform {
  required_version = ">= 0.13.0"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.3.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.0"
    }
  }
}

