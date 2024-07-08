#################################################
# data sources for the infrastructure
#################################################
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_s3_bucket" "asset_bucket" {
  bucket = "${local.asset_bucket.bucket_name}-assets"
}
data "aws_secretsmanager_secret" "secrets" {
  arn = module.secrets_manager.secret_arn
}

#####EBS######
data "aws_ebs_volumes" "volumes" {
  filter {
    name   = "tag:Name"
    values = ["*"]
  }
}
data "aws_ebs_volume" "data" {
  for_each = toset(data.aws_ebs_volumes.volumes.ids)
  filter {
    name   = "volume-id"
    values = [each.value]
  }
}
