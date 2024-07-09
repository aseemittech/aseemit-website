################################################################################
# variables defination
###############################################################################

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
##################################
###         s3           ##
##################################
variable "block_public_acls" {
  type    = bool
  default = true
}
variable "block_public_policy" {
  type    = bool
  default = true
}
variable "versioning_enabled" {
  type    = bool
  default = true
}
variable "control_object_ownership" {
  type    = bool
  default = false
}
#################################################################################
# variables for naming convention module
#################################################################################

variable "naming_environment" {
  description = "Name of the environment"
  type        = string
  default     = "production"
}

### tfstate
variable "tf_namespace" {
  type        = string
  default     = "aseemit"
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "name" {
  type        = string
  default     = "tf-states"
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "enable_server_side_encryption" {
  type        = bool
  description = "Enable DynamoDB server-side encryption"
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
  default     = false
}

variable "enforce_ssl_requests" {
  type        = bool
  description = "Enable/Disable replica for S3 bucket (for cross region replication purpose)"
  default     = false
}
