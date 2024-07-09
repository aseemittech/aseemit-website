locals {
  region = "ap-south-1"
  asset_bucket = {
    bucket_name              = module.naming.resources.s3.name
    target_prefix            = "assets/"
    enabled                  = var.versioning_enabled
    block_public_policy      = var.block_public_policy
    block_public_acls        = var.block_public_acls
    control_object_ownership = var.control_object_ownership
  }
}
