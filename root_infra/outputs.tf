output "tfstate_bucket" {
  value = module.tfstate.s3_bucket_id
}
output "tfstate_dynamodb" {
  value = module.tfstate.dynamodb_table_name
}
output "asset_bucket" {
  value = module.asset_bucket.s3_bucket_id
}
