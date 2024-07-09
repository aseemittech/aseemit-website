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
