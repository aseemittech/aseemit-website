#################################################
# data block for s3 bucket policy
#################################################
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:*", ]
    resources = ["module.log_bucket.s3_bucket_arn", ]
  }
}

data "aws_availability_zones" "available" {}

data "aws_s3_bucket" "asset_bucket" {
  bucket = "${local.asset_bucket.bucket_name}-assets"
}

data "aws_secretsmanager_secret" "secrets" {
  arn = module.secrets_manager.secret_arn
}
