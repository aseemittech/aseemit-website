# AWS Backup plan
resource "aws_backup_plan" "backup_plan" {
  for_each = var.backup_plans
  name     = join("-", [aws_backup_vault.backup_vault[0].name, each.key])

  #Rules
  dynamic "rule" {
    for_each = lookup(each.value, "rules", {})
    content {
      rule_name                = lookup(rule.value, "name", null) # Limit of 50 length
      target_vault_name        = aws_backup_vault.backup_vault[0].name
      schedule                 = lookup(rule.value, "schedule", null)
      enable_continuous_backup = lookup(rule.value, "enable_continuous_backup", null)
      start_window             = lookup(rule.value, "start_window", null)
      completion_window        = lookup(rule.value, "completion_window", null)

      recovery_point_tags = length(lookup(rule.value, "recovery_point_tags", {})) == 0 ? local.tags : lookup(rule.value, "recovery_point_tags")

      # Lifecycle
      dynamic "lifecycle" {
        for_each = length(lookup(rule.value, "lifecycle", {})) == 0 ? [] : [lookup(rule.value, "lifecycle", {})]
        content {
          cold_storage_after = lookup(lifecycle.value, "cold_storage_after", 0)
          delete_after       = lookup(lifecycle.value, "delete_after", 90)
        }
      }

      dynamic "copy_action" {
        for_each = lookup(rule.value, "copy_actions", [])
        content {
          destination_vault_arn = lookup(copy_action.value, "destination_vault_arn", null)

          # Copy Action Lifecycle
          dynamic "lifecycle" {
            for_each = length(lookup(copy_action.value, "lifecycle", {})) == 0 ? [] : [lookup(copy_action.value, "lifecycle", {})]
            content {
              cold_storage_after = lookup(lifecycle.value, "cold_storage_after", 0)
              delete_after       = lookup(lifecycle.value, "delete_after", 90)
            }
          }
        }
      }
    }
  }

  dynamic "advanced_backup_setting" {
    for_each = lookup(each.value, "windows_vss_backup", false) ? [1] : []
    content {
      backup_options = {
        WindowsVSS = "enabled"
      }
      resource_type = "EC2"
    }
  }
  # Tags
  tags       = local.tags
  depends_on = [aws_backup_vault.backup_vault]
}

resource "aws_backup_selection" "backup_vault" {
  for_each      = var.backup_plans
  name          = aws_backup_plan.backup_plan[each.key].name
  iam_role_arn  = var.create_default_backup_role ? aws_iam_role.backup_vault[0].arn : var.backup_iam_role_arn
  plan_id       = aws_backup_plan.backup_plan[each.key].id
  resources     = lookup(each.value, "resources", null)
  not_resources = lookup(each.value, "not_resources", null)

  dynamic "selection_tag" {
    for_each = length(lookup(each.value, "selection_tags", [])) == 0 ? [] : lookup(each.value, "selection_tags", [])
    content {
      type  = lookup(selection_tag.value, "type", null)
      key   = lookup(selection_tag.value, "key", null)
      value = lookup(selection_tag.value, "value", null)
    }
  }

  condition {
    dynamic "string_equals" {
      for_each = lookup(lookup(each.value, "conditions", {}), "string_equals", [])
      content {
        key   = lookup(string_equals.value, "key", null)
        value = lookup(string_equals.value, "value", null)
      }
    }
    dynamic "string_like" {
      for_each = lookup(lookup(each.value, "conditions", {}), "string_like", [])
      content {
        key   = lookup(string_like.value, "key", null)
        value = lookup(string_like.value, "value", null)
      }
    }
    dynamic "string_not_equals" {
      for_each = lookup(lookup(each.value, "conditions", {}), "string_not_equals", [])
      content {
        key   = lookup(string_not_equals.value, "key", null)
        value = lookup(string_not_equals.value, "value", null)
      }
    }
    dynamic "string_not_like" {
      for_each = lookup(lookup(each.value, "conditions", {}), "string_not_like", [])
      content {
        key   = lookup(string_not_like.value, "key", null)
        value = lookup(string_not_like.value, "value", null)
      }
    }
  }
}


## IAM Role for Backup Vault
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "backup_vault" {
  count              = var.create_default_backup_role && var.enabled && var.vault_name != null ? 1 : 0
  name               = "${aws_backup_vault.backup_vault[count.index].name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "backup_vault" {
  count      = var.create_default_backup_role && var.enabled && var.vault_name != null ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup_vault[count.index].name
}

resource "aws_iam_role_policy_attachment" "backup_vault_s3" {
  count      = var.create_default_backup_role && var.enabled && var.vault_name != null ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AWSBackupServiceRolePolicyForS3Backup"
  role       = aws_iam_role.backup_vault[count.index].name
}
