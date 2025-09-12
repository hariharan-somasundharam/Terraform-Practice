# CloudWatch Dashboard - Fixed version
resource "aws_cloudwatch_dashboard" "production_dashboard" {
  dashboard_name = "${var.environment}-server-dashboard"
  dashboard_body = jsonencode({
    widgets = [
      # CPU Utilization Widget
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.ec2_instance_id]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "EC2 CPU Utilization (%)"
          view   = "timeSeries"
          stacked = false
          annotations = {
            horizontal = [
              {
                color = "#ff0000"
                label = "Critical (80%)"
                value = 80
                fill  = "above"
              },
              {
                color = "#ff9900"
                label = "Warning (60%)"
                value = 60
                fill  = "above"
              }
            ]
          }
        }
      },
      
      # ALB Request Count Widget
      {
        type   = "metric"
        x      = 8
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "ALB Request Count"
          view   = "timeSeries"
          stacked = false
        }
      },
      
      # CPU Credit Balance Widget
      {
        type   = "metric"
        x      = 16
        y      = 0
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUCreditBalance", "InstanceId", var.ec2_instance_id]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "CPU Credit Balance"
          view   = "timeSeries"
          stacked = false
          annotations = {
            horizontal = [
              {
                color = "#ff0000"
                label = "Low Credits (50)"
                value = 50
                fill  = "below"
              }
            ]
          }
        }
      },
      
      # CPU Credit Usage Widget
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUCreditUsage", "InstanceId", var.ec2_instance_id]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "CPU Credit Usage"
          view   = "timeSeries"
          stacked = false
        }
      },
      
      # Numeric Widgets for Current Values
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.ec2_instance_id],
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix],
            ["AWS/EC2", "CPUCreditBalance", "InstanceId", var.ec2_instance_id]
          ]
          view   = "singleValue"
          region = var.region
          title  = "Current Metrics Overview"
          period = 300
          stat   = "Average"
        }
      },
      
      # Alarm Status Widget - Fixed with required alarms property
      {
        type   = "alarm"
        x      = 12
        y      = 12
        width  = 12
        height = 6
        properties = {
          title  = "Alarm Status Overview"
          region = var.region
          alarms = [
            "arn:aws:cloudwatch:${var.region}:${data.aws_caller_identity.current.account_id}:alarm:${var.environment}-high-cpu-critical",
            "arn:aws:cloudwatch:${var.region}:${data.aws_caller_identity.current.account_id}:alarm:${var.environment}-high-cpu-warning",
            "arn:aws:cloudwatch:${var.region}:${data.aws_caller_identity.current.account_id}:alarm:${var.environment}-low-cpu-credits"
          ]
        }
      }
    ]
  })
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}
