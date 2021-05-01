
resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "S3_full_access"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : "s3:*",
          "Resource" : "*"
        }
      ]
  })
}

resource "aws_iam_role" "role" {
  name = "s3_full_access"
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

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name   = "s3_full_access_policy"
  role   = aws_iam_role.role.id
  policy = aws_iam_policy.policy.policy
}
