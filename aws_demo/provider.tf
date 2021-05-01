terraform {
  required_providers {
    aws = {
      version = "~>3.27"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
