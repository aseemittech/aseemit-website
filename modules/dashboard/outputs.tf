output "dashboard_arn" {
  description = "The ARN (Amazon Resource Name) of the CloudWatch dashboard."
  value       = aws_cloudwatch_dashboard.main.dashboard_arn
}

output "dashboard_name" {
  description = "The name of the CloudWatch dashboard."
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_body" {
  description = "The body of the CloudWatch dashboard configuration."
  value       = aws_cloudwatch_dashboard.main.dashboard_body
}
