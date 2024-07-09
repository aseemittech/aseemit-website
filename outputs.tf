output "region" {
  description = "Region of deployment"
  value       = var.region
}

output "asset_bucket" {
  value = module.asset_bucket.s3_bucket_id
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
  value       = module.rds.db_instance_endpoint
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = module.rds.db_instance_id
}
# output "sensitive_value" {
#   value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.current.secret_string))
# }


output "db_instance_identifier" {
  description = "The RDS identifier"
  value       = module.rds.db_instance_identifier
}

output "db_instance_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.rds.db_instance_cloudwatch_log_groups
}
