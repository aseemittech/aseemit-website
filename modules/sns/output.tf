################################################################################
# Defines the list of output for the created infrastructure
################################################################################

output "aws_sns_topic_arn" {
  description = "The ARN of the SNS topic"
  value       = try(aws_sns_topic.this[0].arn, null)
}

output "aws_sns_topic_id" {
  description = "The ARN of the SNS topic"
  value       = try(aws_sns_topic.this[0].id, null)
}

output "aws_sns_topic_name" {
  description = "The name of the topic"
  value       = try(aws_sns_topic.this[0].name, null)
}

output "aws_sns_topic_owner" {
  description = "The AWS Account ID of the SNS topic owner"
  value       = try(aws_sns_topic.this[0].owner, null)
}

################################################################################
# Subscription(s)
################################################################################

output "subscriptions" {
  description = "Map of subscriptions created and their attributes"
  value       = aws_sns_topic_subscription.this
}
