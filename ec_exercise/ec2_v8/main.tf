resource "aws_instance" "example" {
  ami           = lookup(var.amis, var.aws_region)
  instance_type = var.instance_type
  subnet_id     = var.aws_subnet_id
  tags = {
    terraform = "true"
  }
}


resource "aws_vpc" "example" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name      = "test"
    terraform = "true"
  }
}