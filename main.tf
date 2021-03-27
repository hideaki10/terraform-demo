terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-northeast-1"
}



//iam_role_policy
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.example.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

//iam_role
resource "aws_iam_role" "example" {
  name = "test_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

//instance_profile

# resource "aws_iam_instance_profile" "example" {
#   role = aws_iam_role.example.name
# }

resource "aws_iam_instance_profile" "example" {
  name = "example"
  # Because this expression refers to the role, Terraform can infer
  # automatically that the role must be created first.
  role = aws_iam_role.example.name
}

//instance 
resource "aws_instance" "exapmle" {
  ami           = "ami-0ab3e16f9c414dee7"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0dcdbd1f5d675b47c"
  //iam_instance_profile = aws_iam_instance_profile.example
  iam_instance_profile = aws_iam_instance_profile.example.name
  # depends_on = [
  #   aws_iam_role_policy.example
  # ]
}

