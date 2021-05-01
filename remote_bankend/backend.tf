terraform {
  required_providers {
    aws = {
      version = "~>3.27"
    }
  }
  backend "s3" {
    bucket         = "terraform-backend-remote-state-aws-demo-71"
    key            = "global/s3/dev/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-banckend-state-lock"
    encrypt        = true
  }
}
