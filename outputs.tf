output "region" {
  description = "Region of deployment"
  value       = var.region
}

################## RDS ####################
output "db_instance_name" {
  description = "The database name"
  value       = module.rds.db_instance_name
}


output "db_instance_username" {
  description = "The master username for the database"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.rds.db_instance_arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = substr(module.rds.db_instance_endpoint, 0, length(module.rds.db_instance_endpoint) - 5)
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_instance_identifier
}

output "db_instance_identifier" {
  description = "The RDS identifier"
  value       = module.rds.db_instance_identifier
}

output "db_instance_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.rds.db_instance_cloudwatch_log_groups
}

################### S3 ####################

output "s3_log_bucket_id" {
  description = "The name of the bucket."
  value       = module.log_bucket.s3_bucket_id
}

output "s3_log_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = module.log_bucket.s3_bucket_arn
}

output "s3_log_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = module.log_bucket.s3_bucket_region
}

output "ebs" {
  value = [for v in data.aws_ebs_volume.data : v.arn]

}
