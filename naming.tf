module "naming" {
  source = "./modules/naming"

  app_name       = "aseemit"
  project_prefix = "wpsite-asm"
  app_name_short = "wps"
  environment    = var.naming_environment
  aws_region     = var.region
  tags = {
    environment = var.naming_environment
    client      = "aseemit-tech"
    terraform   = true
  }
}
