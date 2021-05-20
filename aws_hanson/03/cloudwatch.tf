resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  metric_name         = "CPUUtilization"
  comparsion_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 300
  namespace           = "AWS/EC2"
  threshold           = 70
  name                = "cpu-high"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.blog.name
  }
  alarm_actions = [aws_autoscaling_policy.auto_scaling_high.arn]
}


resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  name                = "cpu-low"
  metric_name         = "CPUUtilization"
  comparsion_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 300
  namespace           = "AWS/EC2"
  threshold           = 70
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.blog.name
  }
  alarm_actions = [aws_autoscaling_policy.auto_scaling_low.arn]
}


