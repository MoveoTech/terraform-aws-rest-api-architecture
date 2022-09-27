terraform {
  required_version = ">= 0.13.0"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.4.6"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.74.2"
    }
  }
}

