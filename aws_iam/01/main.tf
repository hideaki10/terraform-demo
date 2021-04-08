

resource "aws_iam_policy" "policy" {
  name        = "test_polcy"
  path        = "/"
  description = "S3 full access"
  policy = jsonencode(
    {
      version = "2012-10-17"
      Statement = [
        {
          Action = [
            "S3:*",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    }
  )
}

resource "aws_iam_role" "role" {
  name = "s3_full_access"
}

resource "aws_iam_role_policy" "test_policy" {
  name = "s3_full_access_policy"
  role = aws_iam_role.role.id
}
