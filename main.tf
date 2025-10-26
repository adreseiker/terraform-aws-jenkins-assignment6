terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Region comes from variables.tf (var.aws_region)
provider "aws" {
  region = var.aws_region
}

