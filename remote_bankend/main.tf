
module "s3_full_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "test_auto_policy"
  path        = "/"
  description = "this is a policy with moudle"

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
data "aws_caller_identity" "this" {

}

module "iam_assumable_role_sts" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
  "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_role = true

  role_name         = "s3_full_access"
  role_requires_mfa = false

  role_sts_externalid = [
    "s3_full_access",
  ]

  custom_role_policy_arns = [

    module.s3_full_access.arn
  ]
  #  number_of_custom_role_policy_arns = 3
}
