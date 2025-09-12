# outputs.tf
output "dashboard_url" {
  description = "URL of the CloudWatch dashboard"
  value       = "https://console.aws.amazon.com/cloudwatch/home?region=${var.region}#dashboards:name=${aws_cloudwatch_dashboard.production_dashboard.dashboard_name}"
}

output "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.production_dashboard.dashboard_name
}

output "critical_alarms_topic_arn" {
  description = "ARN of the critical alarms SNS topic"
  value       = aws_sns_topic.critical_alarms.arn
}

output "warning_alarms_topic_arn" {
  description = "ARN of the warning alarms SNS topic"
  value       = aws_sns_topic.warning_alarms.arn
}