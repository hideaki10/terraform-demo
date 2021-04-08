terraform {
  required_providers {
    aws = {
      versversion = "~>3.27"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
