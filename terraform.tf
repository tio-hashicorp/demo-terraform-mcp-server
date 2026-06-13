terraform {
  cloud {
    organization = "hashicorp-wwtfo-demo-platform-prod"

    workspaces {
      name    = "<insert-workspace-name>" # must be unique across the organization
      project = "<DDR project name>"      # should be either your **`hc-<username>`** or **`ibm-<username>`** DDR project name
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "random" {}