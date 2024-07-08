#################################################
# Module source for S3 bucket
#################################################
module "log_bucket" {
  source = "./modules/s3"

  bucket = local.log_bucket.bucket_name
  acl    = local.log_bucket.acl
  region = local.region

  # Allow deletion of non-empty bucket
  force_destroy = local.log_bucket.force_destroy

  control_object_ownership = local.log_bucket.control_object_ownership
  object_ownership         = local.log_bucket.object_ownership

  attach_elb_log_delivery_policy = true
}

#################################################
# Codebase bucket for Aseem Site
#################################################
module "codebase_bucket" {
  source = "./modules/s3"

  bucket        = local.codebase_bucket.bucket_name
  force_destroy = true
  region        = local.region

  versioning = {
    enabled = local.codebase_bucket.enabled
  }
}
