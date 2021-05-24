// 
resource "aws_autoscaling_group" "blog" {
  name             = "test-autoscaling"
  desired_capacity = 2
  min_size         = 2
  max_size         = 2
  vpc_zone_identifier = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]
  launch_template {
    id      = aws_launch_template.blog.id
    version = "$Latest"
  }
  health_check_type = "ELB"

  target_group_arns = [aws_alb_target_group.blog_webserver_target_group.arn]

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}


resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.blog.id
  elb                    = aws_alb.blog_webserver.id
}



resource "aws_autoscaling_policy" "auto_scaling_high" {
  name                   = "cpu_high"
  autoscaling_group_name = aws_autoscaling_group.blog.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
}


resource "aws_autoscaling_policy" "auto_scaling_low" {
  name                   = "cpu_low"
  autoscaling_group_name = aws_autoscaling_group.blog.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
}
