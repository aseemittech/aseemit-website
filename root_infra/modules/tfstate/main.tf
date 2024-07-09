################################################################################
# Defines the resources to be created
################################################################################

#tfsec:ignore:aws-s3-enable-bucket-logging  bucket logging is already enabled
resource "aws_s3_bucket" "default" {
  # checkov:skip=CKV2_AWS_62:False Positive. This bucket is the replication destination

  bucket        = format("%s-%s", var.namespace, var.name)
  force_destroy = var.force_destroy

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Owner       = var.owner
  }

  depends_on = [aws_s3_bucket.replication_bucket]
}

resource "aws_s3_bucket_logging" "this" {
  count = var.s3_logging_target_bucket != null ? 1 : 0

  bucket        = aws_s3_bucket.default.id
  target_bucket = var.s3_logging_target_bucket
  target_prefix = var.s3_logging_target_prefix
}

resource "aws_s3_bucket_acl" "default" {
  count  = var.enable_acl ? 1 : 0
  bucket = aws_s3_bucket.default.id
  acl    = var.acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {

  bucket = aws_s3_bucket.default.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.create_kms_key ? aws_kms_key.primary[0].id : null
      sse_algorithm     = var.create_kms_key ? "aws:kms" : "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.default.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = var.mfa_delete ? "Enabled" : "Disabled"
  }

  mfa = var.mfa_delete ? "${var.mfa_serial} ${var.mfa_secret}" : null
}

resource "aws_s3_bucket_lifecycle_configuration" "default" {
  count = var.bucket_lifecycle_enabled ? 1 : 0

  depends_on = [aws_s3_bucket_versioning.default]

  bucket = aws_s3_bucket.default.id

  rule {
    id = "Noncurrent expiration"

    noncurrent_version_expiration {
      noncurrent_days = var.bucket_lifecycle_expiration
    }

    noncurrent_version_transition {
      noncurrent_days = var.bucket_lifecycle_transition_standard_ia
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = var.bucket_lifecycle_transition_glacier
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }

  rule {
    id = "Abort incomplete multipart uploads"
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.default.id
  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  depends_on              = [aws_s3_bucket.default]
}

resource "aws_dynamodb_table" "with_server_side_encryption" {
  count = var.enable_server_side_encryption == "true" ? 1 : 0

  name           = format("%s-%s", var.namespace, var.name)
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  billing_mode   = var.billing_mode
  hash_key       = "LockID" # https://www.terraform.io/docs/backends/types/s3.html#dynamodb_table

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity,
    ]
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    Owner       = var.owner
  }
}

#tfsec:ignore:aws-dynamodb-enable-at-rest-encryption  this can't be only encrypted at rest
#tfsec:ignore:aws-dynamodb-table-customer-key  this can't be encrypted
resource "aws_dynamodb_table" "without_server_side_encryption" {
  count = var.enable_server_side_encryption == "true" ? 0 : 1

  # checkov:skip=CKV_AWS_119:This resource is intended to be used with server side encryption disabled
  name           = format("%s-%s", var.namespace, var.name)
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  billing_mode   = var.billing_mode
  hash_key       = "LockID"
  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity,
    ]
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Terraform   = "true"
    Owner       = var.owner
    Environment = var.environment
  }
}
