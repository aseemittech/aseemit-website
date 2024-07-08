
###########################################################
# Module
###########################################################
module "terraform_state_backend" {
  source                        = "../modules/tfstate"
  namespace                     = var.tf_namespace
  region                        = var.region
  environment                   = var.environment
  name                          = var.name
  bucket_replication_enabled    = var.bucket_replication_enabled
  block_public_acls             = var.block_public_acls
  block_public_policy           = var.block_public_policy
  enable_server_side_encryption = var.enable_server_side_encryption
  restrict_public_buckets       = var.restrict_public_buckets
  enforce_ssl_requests          = var.enforce_ssl_requests
}
