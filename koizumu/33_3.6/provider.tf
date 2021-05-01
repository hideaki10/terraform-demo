terraform {
  required_providers {
    aws = {
      version = "~>3.27"
    }
  }
}


provider "aws" {
  profile = "administrator"
  region  = "ap-northeast-1"
}