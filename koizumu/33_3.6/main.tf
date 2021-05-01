resource "aws_security_group" "example" {
  name = "example-ec2"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }


  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-034968955444c1fd9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.example.id]
  user_data              = <<EOF
   #!/bin/bash
   yum install -y httpd
   systemctl start httpd.service
   EOF
}

output "example_public_dns" {
  value = aws_instance.example.public_dns
}
