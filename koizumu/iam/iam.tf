variable "name" {
}
variable "policy" {

}
variable "identifier" {

}


resource "aws_iam_role" "default" {
  name              = var.name
  assum_role_policy = data.aws_iam_policy_doucument.assume_role.json
}


data "aws_iam_policy_docunment" "assume_role" {
  statement {
    actions = ["sts:AssumRole"]
    principals {
      type       = "Service"
      identifier = [var.identifier]
    }
  }
}

resource "aws_iam_policy" "iam_policy" {
  name   = var.name
  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.iam_policy.arn
}

output "iam_role_arn" {
  value = aws_iam_role.default.arn
}

output "iam_role_name" {
  value = aws_iam_role.default.name
}
