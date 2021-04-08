terraform {
  required_providers {
    aws = {
      version = "~>3.27"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

}

variable "aws_region" {
}

variable "aws_profile" {
}

variable "aws_subnet_id" {

}

variable "ami" {
  type = map(string)
  default = {
    ap-northeast-1 = "ami-034968955444c1fd9"
  }
}

resource "aws_instance" "example" {
  ami           = lookup(var.ami, var.aws_region)
  instance_type = "t2.micro"
  subnet_id     = var.aws_subnet_id
  tags = {
    "terraform" = "true"
  }



}
