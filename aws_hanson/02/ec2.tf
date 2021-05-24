resource "aws_instance" "ec2-blog" {
  count = 2

  ami           = var.aws_ami
  instance_type = "t2.micro"

  availability_zone = var.availability_zone_names[count.index]

  key_name = "amazon-new-key"

  subnet_id = module.vpc.public_subnets[count.index]

  vpc_security_group_ids = [aws_security_group.blog_sg.id]

  tags = {
    "Name" = "Web-blog${count.index + 1}"
  }

  user_data = <<EOF
  #!/bin/bash
  yum -y update
  amazon-linux-extras install php7.2 -y
  yum -y install mysql httpd php-mbstring php-xml gd php-gd
  
  systemctl enable httpd.service 
  systemctl start httpd.service

  id
  # user　→　root 
  # path →　/
  sudo wget http://ja.wordpress.org/latest-ja.tar.gz /
  
  ls -la 

  tar zxvf /latest-ja.tar.gz
  cp -r /wordpress/* /var/www/html/
  chown apache:apache -R /var/www/html  
  EOF
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
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog_sg.id
}

resource "aws_security_group_rule" "http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog_sg.id
}

resource "aws_security_group_rule" "local_web" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.blog_sg.id
}


