module "common_naming" {
  source = "./modules/naming"

  app_name       = local.app_name
  project_prefix = local.project_prefix
  app_name_short = local.common_naming.app_name_short
  environment    = local.environment
  aws_region     = local.region
  tags = {
    environment = var.environment
    client      = local.client
  }
}

module "frontend_naming" {
  source = "./modules/naming"

  app_name       = local.app_name
  project_prefix = local.project_prefix
  app_name_short = local.frontend_naming.app_name_short
  environment    = local.environment
  aws_region     = var.region
  tags = {
    environment = var.environment
    client      = local.client
  }
}

module "backend_naming" {
  source = "./modules/naming"

  app_name       = local.app_name
  project_prefix = local.project_prefix
  app_name_short = local.backend_naming.app_name_short
  environment    = local.environment
  aws_region     = var.region
  tags = {
    environment = var.environment
    client      = local.client
  }
}
