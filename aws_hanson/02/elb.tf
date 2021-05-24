resource "aws_alb" "blog_webserver" {
  name               = "LB-1"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  enable_deletion_protection = false
  security_groups            = [aws_security_group.alb_serurity_group.id]
}

resource "aws_alb_listener" "blog_webserver_listen" {
  load_balancer_arn = aws_alb.blog_webserver.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.blog_webserver_target_group.arn
  }
}

resource "aws_alb_target_group" "blog_webserver_target_group" {
  name        = "TG-01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    protocol          = "HTTP"
    path              = "/readme.html"
    healthy_threshold = 2
    interval          = 10
  }
}


resource "aws_lb_target_group_attachment" "alb_blog_1" {
  port             = 80
  target_id        = aws_instance.ec2-blog[0].id
  target_group_arn = aws_alb_target_group.blog_webserver_target_group.arn
}

resource "aws_lb_target_group_attachment" "alb_blog_2" {
  port             = 80
  target_id        = aws_instance.ec2-blog[1].id
  target_group_arn = aws_alb_target_group.blog_webserver_target_group.arn
}

resource "aws_security_group" "alb_serurity_group" {
  name        = "LB-SG-01"
  description = "ALB"
  vpc_id      = module.vpc.vpc_id
}


resource "aws_security_group_rule" "alb_ttp" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_serurity_group.id
}

resource "aws_security_group_rule" "alb_local" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_serurity_group.id
}



