# Terraform AWS TFstate Backend
Terraform module that provision an S3 bucket to store the `terraform.tfstate` file and a DynamoDB table to lock the state file to prevent concurrent modifications and state corruption.

## Example:

```hcl
module "terraform_state_backend" {
  source                        = "../../"
  namespace                     = var.namespace
  environment                   = var.environment
  name                          = var.name
  bucket_replication_enabled    = var.bucket_replication_enabled
  block_public_acls             = var.block_public_acls
  block_public_policy           = var.block_public_policy
  enable_server_side_encryption = var.enable_server_side_encryption
  restrict_public_buckets       = var.restrict_public_buckets
  enforce_ssl_requests          = var.enforce_ssl_requests
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.with_server_side_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.without_server_side_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_kms_key_policy.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_kms_replica_key.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |
| [aws_s3_bucket.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.replication_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.replication_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.replica_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.default-ssl-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.replication_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.replication_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.replication_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [local_file.backend_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_caller_identity.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default-ssl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.default-ssl-vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | The canned ACL to apply to the S3 bucket | `string` | `"private"` | no |
| <a name="input_backend_config_filename"></a> [backend\_config\_filename](#input\_backend\_config\_filename) | Name of the backend configuration file to generate. | `string` | `"backend.tf"` | no |
| <a name="input_backend_config_filepath"></a> [backend\_config\_filepath](#input\_backend\_config\_filepath) | Directory where the backend configuration file should be generated. | `string` | `""` | no |
| <a name="input_backend_config_profile"></a> [backend\_config\_profile](#input\_backend\_config\_profile) | AWS profile to use when interfacing the backend infrastructure. | `string` | `""` | no |
| <a name="input_backend_config_role_arn"></a> [backend\_config\_role\_arn](#input\_backend\_config\_role\_arn) | ARN of the AWS role to assume when interfacing the backend infrastructure, if any. | `string` | `""` | no |
| <a name="input_backend_config_state_file"></a> [backend\_config\_state\_file](#input\_backend\_config\_state\_file) | Name of the state file in the S3 bucket to use. | `string` | `"terraform.tfstate"` | no |
| <a name="input_backend_config_template_file"></a> [backend\_config\_template\_file](#input\_backend\_config\_template\_file) | Path to the template file to use when generating the backend configuration. | `string` | `""` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | DynamoDB billing mode. Can be PROVISIONED or PAY\_PER\_REQUEST | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_enabled"></a> [bucket\_lifecycle\_enabled](#input\_bucket\_lifecycle\_enabled) | Enable/Disable bucket lifecycle | `bool` | `true` | no |
| <a name="input_bucket_lifecycle_expiration"></a> [bucket\_lifecycle\_expiration](#input\_bucket\_lifecycle\_expiration) | Number of days after which to expunge the objects | `number` | `90` | no |
| <a name="input_bucket_lifecycle_transition_glacier"></a> [bucket\_lifecycle\_transition\_glacier](#input\_bucket\_lifecycle\_transition\_glacier) | Number of days after which to move the data to the GLACIER storage class | `number` | `60` | no |
| <a name="input_bucket_lifecycle_transition_standard_ia"></a> [bucket\_lifecycle\_transition\_standard\_ia](#input\_bucket\_lifecycle\_transition\_standard\_ia) | Number of days after which to move the data to the STANDARD\_IA storage class | `number` | `30` | no |
| <a name="input_bucket_replication_enabled"></a> [bucket\_replication\_enabled](#input\_bucket\_replication\_enabled) | Enable/Disable replica for S3 bucket (for cross region replication purpose) | `bool` | `true` | no |
| <a name="input_bucket_replication_name"></a> [bucket\_replication\_name](#input\_bucket\_replication\_name) | Set custom name for S3 Bucket Replication | `string` | `"replica"` | no |
| <a name="input_bucket_replication_name_suffix"></a> [bucket\_replication\_name\_suffix](#input\_bucket\_replication\_name\_suffix) | Set custom suffix for S3 Bucket Replication IAM Role/Policy | `string` | `"bucket-replication"` | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Whether to create a KMS key | `bool` | `true` | no |
| <a name="input_enable_acl"></a> [enable\_acl](#input\_enable\_acl) | Flag to enable acls | `bool` | `false` | no |
| <a name="input_enable_point_in_time_recovery"></a> [enable\_point\_in\_time\_recovery](#input\_enable\_point\_in\_time\_recovery) | Enable DynamoDB point in time recovery | `bool` | `true` | no |
| <a name="input_enable_server_side_encryption"></a> [enable\_server\_side\_encryption](#input\_enable\_server\_side\_encryption) | Enable DynamoDB server-side encryption | `bool` | `true` | no |
| <a name="input_enforce_ssl_requests"></a> [enforce\_ssl\_requests](#input\_enforce\_ssl\_requests) | Enable/Disable replica for S3 bucket (for cross region replication purpose) | `bool` | `false` | no |
| <a name="input_enforce_vpc_requests"></a> [enforce\_vpc\_requests](#input\_enforce\_vpc\_requests) | Enable/Disable VPC endpoint for S3 bucket | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `"dev"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable | `bool` | `false` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_kms_key_deletion_windows"></a> [kms\_key\_deletion\_windows](#input\_kms\_key\_deletion\_windows) | The number of days after which the KMS key is deleted after destruction of the resource, must be between 7 and 30 days | `number` | `7` | no |
| <a name="input_kms_key_rotation"></a> [kms\_key\_rotation](#input\_kms\_key\_rotation) | Specifies whether key rotation is enabled | `bool` | `true` | no |
| <a name="input_mfa_delete"></a> [mfa\_delete](#input\_mfa\_delete) | A boolean that indicates that versions of S3 objects can only be deleted with MFA. ( Terraform cannot apply changes of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629 ) | `bool` | `false` | no |
| <a name="input_mfa_secret"></a> [mfa\_secret](#input\_mfa\_secret) | The numbers displayed on the MFA device when applying. Necessary when mfa\_delete is true. | `string` | `""` | no |
| <a name="input_mfa_serial"></a> [mfa\_serial](#input\_mfa\_serial) | The serial number of the MFA device to use. Necessary when mfa\_delete is true. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `"terraform"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Name to be used on all the resources as identifier | `string` | `""` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | DynamoDB read capacity units | `number` | `5` | no |
| <a name="input_region"></a> [region](#input\_region) | Region be used for all the resources | `string` | `"us-east-1"` | no |
| <a name="input_replica_logging_target_bucket"></a> [replica\_logging\_target\_bucket](#input\_replica\_logging\_target\_bucket) | The name of the bucket for log storage. The "S3 log delivery group" should have Objects-write und ACL-read permissions on the bucket. | `string` | `null` | no |
| <a name="input_replica_logging_target_prefix"></a> [replica\_logging\_target\_prefix](#input\_replica\_logging\_target\_prefix) | The prefix to apply on bucket logs, e.g "logs/". | `string` | `""` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_s3_logging_target_bucket"></a> [s3\_logging\_target\_bucket](#input\_s3\_logging\_target\_bucket) | The name of the bucket for log storage. The "S3 log delivery group" should have Objects-write und ACL-read permissions on the bucket. | `string` | `null` | no |
| <a name="input_s3_logging_target_prefix"></a> [s3\_logging\_target\_prefix](#input\_s3\_logging\_target\_prefix) | The prefix to apply on bucket logs, e.g "logs/". | `string` | `""` | no |
| <a name="input_vpc_ids_list"></a> [vpc\_ids\_list](#input\_vpc\_ids\_list) | VPC id to access the S3 bucket vía vpc endpoint. The VPCe must be in the same AWS Region as the bucket. | `list(string)` | `[]` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | DynamoDB write capacity units | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | DynamoDB table ARN |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | DynamoDB table ID |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | DynamoDB table name |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 bucket ARN |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | S3 bucket domain name |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 bucket ID |
<!-- END_TF_DOCS -->
