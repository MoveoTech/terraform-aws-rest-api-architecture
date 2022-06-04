terraform {
  required_version = ">= 0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.3"
    }
  }
}

