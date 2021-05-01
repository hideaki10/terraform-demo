
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

}


#ec2

resource "aws_instance" "ec2-blog" {
  ami           = var.aws_ami
  instance_type = "t2.micro"

  availability_zone = "${var.aws_region}a"

  key_name = "amazon-new-key"

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids =[aws_security_group.blog_sg.id]
}


resource "aws_security_group" "blog_sg" {
  name        = "Weg_Sg01"
  description = "webserver"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "ssh"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.blog_sg.id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.blog_sg.id
}

resource "aws_security_group_rule" "http" {
  type              = "engress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.blog_sg.id
}

resource "aws_security_group_rule" "http" {
  type              = "engress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = aws_security_group.blog_sg.id
}