# aseemit-website
Wbsite codebase for aseemit 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/elb | n/a |
| <a name="module_backend_naming"></a> [backend\_naming](#module\_backend\_naming) | ./modules/naming | n/a |
| <a name="module_backup"></a> [backup](#module\_backup) | ./modules/aws-backup | n/a |
| <a name="module_codebase_bucket"></a> [codebase\_bucket](#module\_codebase\_bucket) | ./modules/s3 | n/a |
| <a name="module_common_naming"></a> [common\_naming](#module\_common\_naming) | ./modules/naming | n/a |
| <a name="module_destination_vault"></a> [destination\_vault](#module\_destination\_vault) | ./modules/aws-backup | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | terraform-aws-modules/ec2-instance/aws | 5.6.1 |
| <a name="module_frontend_naming"></a> [frontend\_naming](#module\_frontend\_naming) | ./modules/naming | n/a |
| <a name="module_log_bucket"></a> [log\_bucket](#module\_log\_bucket) | ./modules/s3 | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ./modules/rds | n/a |
| <a name="module_route53_hosted_zone"></a> [route53\_hosted\_zone](#module\_route53\_hosted\_zone) | ./modules/zones | n/a |
| <a name="module_sns"></a> [sns](#module\_sns) | ./modules/sns | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_vault_notifications.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_notifications) | resource |
| [aws_iam_instance_profile.instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.s3_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_ssm_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.secrets_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_task_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3_read_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.frontend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ebs_volume.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ebs_volume) | data source |
| [aws_ebs_volumes.volumes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ebs_volumes) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in gigabytes | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | public ip allocation | `bool` | n/a | yes |
| <a name="input_backend_port"></a> [backend\_port](#input\_backend\_port) | value of the backend port | `number` | n/a | yes |
| <a name="input_backend_protocol"></a> [backend\_protocol](#input\_backend\_protocol) | value of the backend protocol | `string` | n/a | yes |
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | instance profile creation | `bool` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The database name | `string` | n/a | yes |
| <a name="input_disable_api_stop"></a> [disable\_api\_stop](#input\_disable\_api\_stop) | status of the api stop | `bool` | n/a | yes |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | Type of the ami that is being used | `string` | n/a | yes |
| <a name="input_enable_rotation"></a> [enable\_rotation](#input\_enable\_rotation) | Determines whether secret rotation is enabled | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Determines whether the S3 bucket versioning is enabled | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | n/a | yes |
| <a name="input_hibernation"></a> [hibernation](#input\_hibernation) | ec2 instance hibernation status | `bool` | n/a | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type of the RDS instance | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of the instance that is being used | `string` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | Determines whether the ALB is internal or internet facing | `bool` | n/a | yes |
| <a name="input_major_engine_version"></a> [major\_engine\_version](#input\_major\_engine\_version) | Specifies the major version of the engine that this option group should be associated with | `string` | `null` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | monitoring configuration | `bool` | n/a | yes |
| <a name="input_number_of_azs"></a> [number\_of\_azs](#input\_number\_of\_azs) | number of availability zones | `number` | `3` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30` | `number` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_root_throughput"></a> [root\_throughput](#input\_root\_throughput) | throughput for the root volume | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | root volume size | `string` | n/a | yes |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | root volume type | `string` | n/a | yes |
| <a name="input_rule_completion_window"></a> [rule\_completion\_window](#input\_rule\_completion\_window) | The amount of time AWS Backup attempts a backup before canceling the job and returning an error | `string` | `""` | no |
| <a name="input_rule_schedule"></a> [rule\_schedule](#input\_rule\_schedule) | A CRON expression specifying when AWS Backup initiates a backup job | `string` | `""` | no |
| <a name="input_rule_start_window"></a> [rule\_start\_window](#input\_rule\_start\_window) | The amount of time in minutes before beginning a backup | `string` | `""` | no |
| <a name="input_subscriptions"></a> [subscriptions](#input\_subscriptions) | List of maps containing subscriptions | `any` | n/a | yes |
| <a name="input_target_group_index"></a> [target\_group\_index](#input\_target\_group\_index) | value of the target group index | `number` | n/a | yes |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | target type for load balancer | `string` | n/a | yes |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether to use name prefix or not | `bool` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | user data definition | `string` | n/a | yes |
| <a name="input_user_data_replace_on_change"></a> [user\_data\_replace\_on\_change](#input\_user\_data\_replace\_on\_change) | condition of the instance that is being used | `bool` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Range of VPC cidr | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | The ARN of the RDS instance |
| <a name="output_db_instance_cloudwatch_log_groups"></a> [db\_instance\_cloudwatch\_log\_groups](#output\_db\_instance\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The connection endpoint |
| <a name="output_db_instance_id"></a> [db\_instance\_id](#output\_db\_instance\_id) | The RDS instance ID |
| <a name="output_db_instance_identifier"></a> [db\_instance\_identifier](#output\_db\_instance\_identifier) | The RDS identifier |
| <a name="output_db_instance_name"></a> [db\_instance\_name](#output\_db\_instance\_name) | The database name |
| <a name="output_db_instance_username"></a> [db\_instance\_username](#output\_db\_instance\_username) | The master username for the database |
| <a name="output_ebs"></a> [ebs](#output\_ebs) | n/a |
| <a name="output_region"></a> [region](#output\_region) | Region of deployment |
| <a name="output_s3_log_bucket_arn"></a> [s3\_log\_bucket\_arn](#output\_s3\_log\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
| <a name="output_s3_log_bucket_id"></a> [s3\_log\_bucket\_id](#output\_s3\_log\_bucket\_id) | The name of the bucket. |
| <a name="output_s3_log_bucket_region"></a> [s3\_log\_bucket\_region](#output\_s3\_log\_bucket\_region) | The AWS region this bucket resides in. |
<!-- END_TF_DOCS -->
