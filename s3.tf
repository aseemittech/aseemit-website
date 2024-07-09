#################################################
# Module source for S3 bucket
#################################################
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
  force_destroy = true
}
