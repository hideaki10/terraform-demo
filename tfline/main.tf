resource "aws_instance" "foo" {
  ami           = "ami-1234xxxx1234yyyy"
  instance_type = "t3.small" # invalid type!
}
