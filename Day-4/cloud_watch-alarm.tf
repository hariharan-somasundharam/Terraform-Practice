# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "high_cpu_critical" {
  alarm_name          = "${var.environment}-high-cpu-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "CPU utilization exceeds 80% (Critical)"
  alarm_actions       = [aws_sns_topic.critical_alarms.arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = {
    Severity = "Critical"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_warning" {
  alarm_name          = "${var.environment}-high-cpu-warning"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 60
  alarm_description   = "CPU utilization exceeds 60% (Warning)"
  alarm_actions       = [aws_sns_topic.warning_alarms.arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = {
    Severity = "Warning"
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_credits" {
  alarm_name          = "${var.environment}-low-cpu-credits"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUCreditBalance"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Minimum"
  threshold           = 50
  alarm_description   = "CPU credit balance below 50 (Critical)"
  alarm_actions       = [aws_sns_topic.critical_alarms.arn]
  dimensions = {
    InstanceId = var.ec2_instance_id
  }
  tags = {
    Severity = "Critical"
  }
}

