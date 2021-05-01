terraform {
  required_providers {
    aws = {
      version = "~>3.27"
    }
  }
  backend "s3" {
  }
}
