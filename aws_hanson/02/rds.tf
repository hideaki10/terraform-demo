resource "aws_db_subnet_group" "db_sbnet" {
  name       = "wordpess"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], ]
}


resource "aws_db_instance" "blog" {

  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "admin"
  password               = var.rds_password
  port                   = 3306
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  db_subnet_group_name = aws_db_subnet_group.db_sbnet.name
  deletion_protection  = false
  skip_final_snapshot  = true
  multi_az             = true
}


resource "aws_security_group" "rds_sg" {
  name        = "rds_Sg01"
  description = "rds_sg"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.blog_sg.id
  security_group_id        = aws_security_group.rds_sg.id
}


resource "aws_security_group_rule" "local_rds" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_sg.id
}

