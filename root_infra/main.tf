###########################################################
# Module
###########################################################
module "asset_bucket" {
  source                   = "./modules/s3"
  bucket                   = "${local.asset_bucket.bucket_name}-assets"
  control_object_ownership = local.asset_bucket.control_object_ownership
  policy                   = data.aws_iam_policy_document.bucket_policy.json
  block_public_acls        = local.asset_bucket.block_public_acls
  block_public_policy      = local.asset_bucket.block_public_policy
  region                   = local.region
  versioning = {
    enabled = local.asset_bucket.enabled
  }
}

module "tfstate" {
  source                        = "./modules/tfstate"
  namespace                     = var.tf_namespace
  region                        = var.region
  name                          = var.name
  bucket_replication_enabled    = var.bucket_replication_enabled
  block_public_acls             = var.block_public_acls
  block_public_policy           = var.block_public_policy
  enable_server_side_encryption = var.enable_server_side_encryption
  restrict_public_buckets       = var.restrict_public_buckets
  enforce_ssl_requests          = var.enforce_ssl_requests
}
