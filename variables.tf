################################################################################
# variables defination
################################################################################
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
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

#################################################################################
# variables for VPC
#################################################################################
variable "vpc_cidr" {
  description = "Range of VPC cidr"
  type        = string
}

variable "number_of_azs" {
  description = "number of availability zones"
  type        = number
  default     = 3
}

################################################################################
# variables for RDS
################################################################################
variable "db_name" {
  description = "The database name"
  type        = string
}
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "create_random_password" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 5
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = false
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = null
}

################################################################################
# variables for EC2
################################################################################
variable "instance_type" {
  description = "Type of the instance that is being used"
  type        = string
}
variable "ec2_ami" {
  description = "Type of the ami that is being used"
  type        = string
}


variable "hibernation" {
  description = "ec2 instance hibernation status"
  type        = bool
}

variable "associate_public_ip_address" {
  description = "public ip allocation"
  type        = bool
}

variable "disable_api_stop" {
  description = "status of the api stop"
  type        = bool
}

variable "create_iam_instance_profile" {
  description = "instance profile creation"
  type        = bool
}
variable "monitoring" {
  description = "monitoring configuration"
  type        = bool
}
variable "user_data_replace_on_change" {
  description = "condition of the instance that is being used"
  type        = bool
}
variable "user_data" {
  description = "user data definition"
  type        = string
}
variable "root_volume_type" {
  description = "root volume type"
  type        = string
}
variable "root_volume_size" {
  description = "root volume size"
  type        = string
}
variable "root_throughput" {
  description = "throughput for the root volume"
  type        = string
}

################################################################################
# variables for secrets manager
################################################################################
variable "enable_rotation" {
  description = "Determines whether secret rotation is enabled"
  type        = bool
  default     = true
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be `0` to force deletion without recovery or range from `7` to `30` days. The default value is `30`"
  type        = number
  default     = null
}

#################################################
############        SNS Topic             #######

variable "use_name_prefix" {
  description = "Determines whether to use name prefix or not"
  type        = bool
}

variable "subscriptions" {
  description = "List of maps containing subscriptions"
  type        = any
}
