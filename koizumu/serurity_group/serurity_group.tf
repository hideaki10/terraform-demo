
variable "name" {

}

variable "vpc_id" {

}
variable "port" {

}

variable "cidr_blocks" {
  type = list(string)
}

resource "aws_security_group" "example_security_group" {
  name   = var.name
  vpc_id = var.vpc_id
}

#インバウンド
resource "aws_security_group_rule" "ingress_example" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.example_security_group.id
}

#アウトバウンド
resource "aws_security_group_rule" "ingress_example" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.cidr_blocks
  security_group_id = aws_security_group.example_security_group.id
}

output "security_group_id" {
  value = aws_security_group.example_security_group.id
}

