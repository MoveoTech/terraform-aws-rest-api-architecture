terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.1"
    }

    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.3.1"
    }
  }
}
