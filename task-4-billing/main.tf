terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Billing alarms must be in us-east-1
}

# SNS Topic for Alarm Notifications
resource "aws_sns_topic" "yash_uppal_billing_alerts" {
  name = "yash-uppal-billing-alerts"

  tags = {
    Name = "Yash_Uppal_Billing_Alerts"
  }
}

# SNS Topic Subscription (replace with your email)
resource "aws_sns_topic_subscription" "yash_uppal_billing_email" {
  topic_arn = aws_sns_topic.yash_uppal_billing_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"  # CHANGE THIS TO YOUR EMAIL
}

# CloudWatch Billing Alarm - ₹100 threshold
resource "aws_cloudwatch_metric_alarm" "yash_uppal_billing_alarm" {
  alarm_name          = "Yash_Uppal_Billing_Alarm_100_INR"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 86400  # 1 day
  statistic           = "Maximum"
  threshold           = 100    # ₹100
  alarm_description   = "Alert when AWS estimated charges reach ₹100"
  alarm_actions       = [aws_sns_topic.yash_uppal_billing_alerts.arn]
  treat_missing_data  = "notBreaching"

  dimensions = {
    Currency = "INR"
  }

  tags = {
    Name = "Yash_Uppal_Billing_Alarm"
  }
}

# CloudWatch Alarm for Free Tier Usage - EC2
resource "aws_cloudwatch_metric_alarm" "yash_uppal_free_tier_ec2" {
  alarm_name          = "Yash_Uppal_Free_Tier_EC2_Alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 3600  # 1 hour
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alert if EC2 CPU usage exceeds 80% (potential extra charges)"
  alarm_actions       = [aws_sns_topic.yash_uppal_billing_alerts.arn]
  treat_missing_data  = "notBreaching"

  tags = {
    Name = "Yash_Uppal_Free_Tier_EC2_Alert"
  }
}

# CloudWatch Alarm for NAT Gateway Data Transfer
resource "aws_cloudwatch_metric_alarm" "yash_uppal_nat_data_transfer" {
  alarm_name          = "Yash_Uppal_NAT_Data_Transfer_Alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "BytesOutToDestination"
  namespace           = "AWS/NatGateway"
  period              = 3600
  statistic           = "Sum"
  threshold           = 1073741824  # 1 GB in bytes
  alarm_description   = "Alert on high data transfer through NAT Gateway (potential charges)"
  alarm_actions       = [aws_sns_topic.yash_uppal_billing_alerts.arn]
  treat_missing_data  = "notBreaching"

  tags = {
    Name = "Yash_Uppal_NAT_Transfer_Alert"
  }
}

# Outputs
output "sns_topic_arn" {
  value       = aws_sns_topic.yash_uppal_billing_alerts.arn
  description = "SNS Topic ARN for billing alerts"
}

output "billing_alarm_name" {
  value       = aws_cloudwatch_metric_alarm.yash_uppal_billing_alarm.alarm_name
  description = "Name of the billing alarm"
}
