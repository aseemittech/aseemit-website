################################################################################
# Defines the list of output for the created infrastructure
################################################################################

output "backup_vault_id" {
  description = "The ARN of the Backup Vault"
  value       = try(aws_backup_vault.backup_vault[0].id, null)
}

output "backup_vault_arn" {
  description = "The ARN of the Backup Vault"
  value       = try(aws_backup_vault.backup_vault[0].arn, null)
}

output "backup_plans" {
  description = "The ARNs of the Backup Vault Plans"
  value       = try(aws_backup_plan.backup_plan, null)
}

output "backup_iam_role_name" {
  description = "The Name of the Backup Vault IAM Role"
  value       = try(aws_iam_role.backup_vault[0].name, null)
}

output "backup_iam_role_arn" {
  description = "The ARN of the Backup Vault IAM Role"
  value       = var.create_default_backup_role ? try(aws_iam_role.backup_vault[0].arn, null) : var.backup_iam_role_arn
}
