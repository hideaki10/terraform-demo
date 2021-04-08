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

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "aws_profile" {
  default = "administrator"
}

variable "amis" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-034968955444c1fd9"
  }
}

resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = "t2.micro"
  tags = {
    "terraform" = "true"
  }
}

