# To get the environment from the user
variable "environment" {
  description = "Environment name [prod/staging/dev/uat]:"
  type        = string
  default     = "prod"
}

# To get application load balancer's ARN from the user
variable "alb_arn_suffix" {
  description = "Enter ur ALB's ARN (e.g., app/my-alb/1234567890abcdef):"
  type        = string
}

#  To get instance ID from the user
variable "ec2_instance_id" {
  description = "EC2 instance ID to monitor"
  type        = string
}

#  To get the region from the user
variable "region" {
    description = "Enter ur Instance region [eg: us-east-1/us-west-2]:"
    type = string
}

# To get the email for SNS Topic Subscription
variable "sns_topic_email" {
    description = "Enter the email for subcription:"
    type = string
}