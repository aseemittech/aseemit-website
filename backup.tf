module "destination_vault" {
  source     = "./modules/aws-backup"
  region     = "us-east-1"
  vault_name = local.backup.destination_vault_name
}

module "backup" {
  source     = "./modules/aws-backup"
  vault_name = local.backup.vault_name
  region     = "ap-south-1"
  backup_plans = {
    "rds" = {
      resources = [module.rds.db_instance_arn]
      rules = [
        {
          name              = "rds_continuous_backup_rule"
          schedule          = var.rule_schedule
          start_window      = var.rule_start_window
          target_vault_name = module.backup.backup_vault_id
          completion_window = var.rule_completion_window
          copy_actions = [{
            destination_vault_arn = module.destination_vault.backup_vault_arn
            lifecycle = {
              cold_storage_after = 0
              delete_after       = 90
            }
          }]
        }
      ]
    }
  }

}
