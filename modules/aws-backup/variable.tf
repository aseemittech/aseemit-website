################################################################################
# Input variables for the main.tf file
################################################################################

variable "enabled" {
  description = "Change to false to avoid deploying any AWS Backup resources"
  type        = bool
  default     = true
}
variable "region" {
  description = "Region be used for all the resources"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "vault_name" {
  description = "Name of the backup vault to create. If not given, AWS use default"
  type        = string
}

variable "vault_kms_key_arn" {
  description = "The server-side encryption key that is used to protect your backups"
  type        = string
  default     = null
}

variable "vault_force_destroy" {
  description = "A boolean that indicates that all recovery points stored in the vault are deleted so that the vault can be destroyed without error."
  type        = bool
  default     = false
}

#
# AWS Backup vault lock configuration
#
variable "locked" {
  description = "Change to true to add a lock configuration for the backup vault"
  type        = bool
  default     = false
}

variable "changeable_for_days" {
  description = "The number of days before the lock date. If omitted creates a vault lock in governance mode, otherwise it will create a vault lock in compliance mode"
  type        = number
  default     = null
}

variable "max_retention_days" {
  description = "The maximum retention period that the vault retains its recovery points"
  type        = number
  default     = null
}

variable "min_retention_days" {
  description = "The minimum retention period that the vault retains its recovery points"
  type        = number
  default     = 1
}

variable "backup_plans" {
  description = "Group of backup vault plans"
  type        = any
  default     = {}
}

variable "vault_policy_statements" {
  description = "A map of IAM policy statements for custom permission usage"
  type        = any
  default     = {}
}

variable "create_default_backup_role" {
  description = "Wheter to create backup role for the backup vault"
  type        = bool
  default     = true
}

variable "backup_iam_role_arn" {
  description = "External backup IAM Role Arn"
  type        = string
  default     = null
}
