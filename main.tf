terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.27"
    }
  }
}

//iam_role_policy
resource "aws_iam_role_policy" "example" {
  name = "test_role_policy"
  role = aws_iam_role.example.name
  policy = jsonencode({
    "Statement" = [
      {
        "Action" = "s3:*"
        "Effect" = "Allow"
      }
    ]
  })
}

//iam_role
resource "aws_iam_role" "example" {
  name               = "test_role"
  assume_role_policy = "..."
}

//instance_profile

resource "aws_iam_instance_profile" "example" {
  role = aws_iam_role.example.name
}

//instance 
resource "aws_instance" "exapmle" {
  ami                  = "ami-0ab3e16f9c414dee7"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-0dcdbd1f5d675b47c"
  iam_instance_profile = aws_iam_instance_profile.example

  depends_on = [
    aws_iam_role_policy.example
  ]
}

