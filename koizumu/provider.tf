terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.27"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}


variable "aws_profile" {
}
variable "aws_region" {
}
