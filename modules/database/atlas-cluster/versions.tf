terraform {
  required_version = ">= 0.13.0"
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = ">= 1.3.1"
    }
  }
}
