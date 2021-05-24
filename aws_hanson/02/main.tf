
#vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-blog"

  cidr = "10.0.0.0/21"

  azs = [
    "${var.aws_region}a",
    "${var.aws_region}c"
  ]

  public_subnets = [
    "10.0.1.0/24",
    "10.0.3.0/24"
  ]

  private_subnets = [
    "10.0.2.0/24",
    "10.0.4.0/24"
  ]

  private_subnet_tags = {
    "Name" : "private",
  }

  public_subnet_tags = {
    "Name" : "public"
  }


}
