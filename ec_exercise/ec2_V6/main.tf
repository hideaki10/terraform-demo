


resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  subnet_id     = var.aws_subnet_id
  tags = {
    terraform = "true"
  }
}
