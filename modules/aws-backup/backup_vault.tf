# AWS Backup vault
resource "aws_backup_vault" "backup_vault" {
  count         = var.enabled && var.vault_name != null ? 1 : 0
  name          = var.vault_name
  kms_key_arn   = var.vault_kms_key_arn
  force_destroy = var.vault_force_destroy
  tags          = local.tags
}

data "aws_iam_policy_document" "backup_vault" {
  count = var.enabled && var.vault_name != null ? 1 : 0

  statement {
    effect = "Allow"
    sid    = "VaultCreator"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }


    actions = [
      "backup:DescribeBackupVault",
      "backup:DeleteBackupVault",
      "backup:PutBackupVaultAccessPolicy",
      "backup:DeleteBackupVaultAccessPolicy",
      "backup:GetBackupVaultAccessPolicy",
      "backup:StartBackupJob",
      "backup:GetBackupVaultNotifications",
      "backup:PutBackupVaultNotifications",
    ]

    resources = [aws_backup_vault.backup_vault[count.index].arn]
  }

  statement {
    effect = "Allow"
    sid    = "AllowCopy"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = [
      "backup:CopyIntoBackupVault",
    ]

    resources = ["*"]
  }

  dynamic "statement" {
    for_each = var.vault_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = [aws_backup_vault.backup_vault[count.index].arn]
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_backup_vault_policy" "backup_vault" {
  count             = var.enabled && var.vault_name != null ? 1 : 0
  backup_vault_name = aws_backup_vault.backup_vault[count.index].name
  policy            = data.aws_iam_policy_document.backup_vault[count.index].json
}

# AWS Backup vault lock configuration
resource "aws_backup_vault_lock_configuration" "backup_vault_lock_configuration" {
  count               = var.locked && var.vault_name != null ? 1 : 0
  backup_vault_name   = aws_backup_vault.backup_vault[count.index].name
  changeable_for_days = var.changeable_for_days
  max_retention_days  = var.max_retention_days
  min_retention_days  = var.min_retention_days
}
