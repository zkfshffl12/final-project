output "application_log_group_name" {
  description = "The name of the application log group"
  value       = aws_cloudwatch_log_group.application.name
}

output "ec2_log_group_name" {
  description = "The name of the EC2 log group"
  value       = aws_cloudwatch_log_group.ec2.name
}

output "dashboard_name" {
  description = "The name of the CloudWatch dashboard"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}
