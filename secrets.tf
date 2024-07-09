################################################################################
# Secrets manager module 
################################################################################
resource "random_string" "rand4" {
  length  = 4
  special = false
  upper   = false
}

module "secrets_manager" {
  source = "./modules/secrets"
  region = var.region
  # Secrets Manager
  name                    = "${local.secrets.name_prefix}-db-secret-${random_string.rand4.result}"
  description             = local.secrets.description
  enable_rotation         = local.secrets.enable_rotation
  ignore_secret_changes   = local.secrets.ignore_secret_changes
  recovery_window_in_days = 0
  create                  = true

  secret_string = jsonencode({
    username = module.rds.db_instance_username,
    password = module.rds.db_instance_password
  })

  tags = local.tags

}
