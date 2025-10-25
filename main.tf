#################
# main.tf (CLEAN)
# - No duplicate data sources
# - No default VPC lookups
# - Provider uses region from variable
#################

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

# (Intentionally no data sources here; AMI is resolved in instances.tf)
