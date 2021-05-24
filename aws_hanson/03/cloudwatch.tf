resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 300
  namespace           = "AWS/EC2"
  threshold           = 70
  alarm_name          = "cpu-high"
  evaluation_periods  = 30
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.blog.name
  }
  alarm_actions = [aws_autoscaling_policy.auto_scaling_high.arn]
}


resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu-low"
  metric_name         = "CPUUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Average"
  period              = 300
  namespace           = "AWS/EC2"
  threshold           = 70
  evaluation_periods  = 30
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.blog.name
  }
  alarm_actions = [aws_autoscaling_policy.auto_scaling_low.arn]
}


