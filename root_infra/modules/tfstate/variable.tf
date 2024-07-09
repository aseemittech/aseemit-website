################################################################################
# Input variables for the main.tf file
################################################################################
variable "owner" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "region" {
  description = "Region be used for all the resources"
  type        = string
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "create_kms_key" {
  type        = bool
  default     = true
  description = "Whether to create a KMS key"
}

variable "kms_key_deletion_windows" {
  type        = number
  default     = 7
  description = "The number of days after which the KMS key is deleted after destruction of the resource, must be between 7 and 30 days"
}

variable "kms_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}

variable "name" {
  type        = string
  default     = "terraform"
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket"
  default     = "private"
}

variable "read_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB write capacity units"
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = false
}

variable "mfa_delete" {
  type        = bool
  description = "A boolean that indicates that versions of S3 objects can only be deleted with MFA. ( Terraform cannot apply changes of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629 )"
  default     = false
}

variable "mfa_serial" {
  type        = string
  description = "The serial number of the MFA device to use. Necessary when mfa_delete is true."
  default     = ""
}

variable "mfa_secret" {
  type        = string
  description = "The numbers displayed on the MFA device when applying. Necessary when mfa_delete is true."
  default     = ""
}

variable "enable_server_side_encryption" {
  type        = bool
  description = "Enable DynamoDB server-side encryption"
  default     = true
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable DynamoDB point in time recovery"
  default     = true
}

variable "billing_mode" {
  type        = string
  description = "DynamoDB billing mode. Can be PROVISIONED or PAY_PER_REQUEST"
  default     = "PAY_PER_REQUEST"
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = true
}

variable "bucket_replication_enabled" {
  type        = bool
  description = "Enable/Disable replica for S3 bucket (for cross region replication purpose)"
  default     = true
}

variable "bucket_replication_name" {
  type        = string
  default     = "replica"
  description = "Set custom name for S3 Bucket Replication"
}

variable "bucket_replication_name_suffix" {
  type        = string
  default     = "bucket-replication"
  description = "Set custom suffix for S3 Bucket Replication IAM Role/Policy"
}

variable "enforce_ssl_requests" {
  type        = bool
  description = "Enable/Disable replica for S3 bucket (for cross region replication purpose)"
  default     = false
}

variable "enforce_vpc_requests" {
  type        = bool
  description = "Enable/Disable VPC endpoint for S3 bucket"
  default     = false
}

variable "vpc_ids_list" {
  type        = list(string)
  description = "VPC id to access the S3 bucket vía vpc endpoint. The VPCe must be in the same AWS Region as the bucket."
  default     = []
}

variable "s3_logging_target_bucket" {
  description = "The name of the bucket for log storage. The \"S3 log delivery group\" should have Objects-write und ACL-read permissions on the bucket."
  type        = string
  default     = null
}

variable "s3_logging_target_prefix" {
  description = "The prefix to apply on bucket logs, e.g \"logs/\"."
  type        = string
  default     = ""
}

variable "replica_logging_target_bucket" {
  description = "The name of the bucket for log storage. The \"S3 log delivery group\" should have Objects-write und ACL-read permissions on the bucket."
  type        = string
  default     = null
}

variable "replica_logging_target_prefix" {
  description = "The prefix to apply on bucket logs, e.g \"logs/\"."
  type        = string
  default     = ""
}


variable "bucket_lifecycle_enabled" {
  type        = bool
  description = "Enable/Disable bucket lifecycle"
  default     = true
}

variable "bucket_lifecycle_expiration" {
  type        = number
  default     = 90
  description = "Number of days after which to expunge the objects"
}

variable "bucket_lifecycle_transition_glacier" {
  type        = number
  default     = 60
  description = "Number of days after which to move the data to the GLACIER storage class"
}

variable "bucket_lifecycle_transition_standard_ia" {
  type        = number
  default     = 30
  description = "Number of days after which to move the data to the STANDARD_IA storage class"
}

variable "backend_config_template_file" {
  type        = string
  description = "Path to the template file to use when generating the backend configuration."
  default     = ""
}

variable "backend_config_filepath" {
  type        = string
  description = "Directory where the backend configuration file should be generated."
  default     = ""
}

variable "backend_config_filename" {
  type        = string
  description = "Name of the backend configuration file to generate."
  default     = "backend.tf"
}

variable "backend_config_profile" {
  type        = string
  description = "AWS profile to use when interfacing the backend infrastructure."
  default     = ""
}

variable "backend_config_role_arn" {
  type        = string
  description = "ARN of the AWS role to assume when interfacing the backend infrastructure, if any."
  default     = ""
}

variable "backend_config_state_file" {
  type        = string
  description = "Name of the state file in the S3 bucket to use."
  default     = "terraform.tfstate"
}

variable "enable_acl" {
  type        = bool
  default     = false
  description = "Flag to enable acls"

}
