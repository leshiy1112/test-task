terraform {
  required_version = ">= 0.12.20, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }
}