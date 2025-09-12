# SNS Topics for notifications
# SNS Topic for alarm for CPU Utilization >= 80%
resource "aws_sns_topic" "critical_alarms" {
  name = "${var.environment}-critical-alarms-topic"
}

resource "aws_sns_topic_subscription" "critical_alarms_email" {
  topic_arn = aws_sns_topic.critical_alarms.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email
}

# SNS Topic for alarm for CPU Utilization >= 50%
resource "aws_sns_topic" "warning_alarms" {
  name = "${var.environment}-warning-alarms-topic"
}

resource "aws_sns_topic_subscription" "warning_alarms_email" {
  topic_arn = aws_sns_topic.warning_alarms.arn
  protocol  = "email"
  endpoint  = var.sns_topic_email
}