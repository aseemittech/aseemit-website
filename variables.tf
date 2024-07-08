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

variable "environment" {
  description = "Name of the environment"
  type        = string
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


#################################################################################
# Variables for ALB
#################################################################################

variable "internal" {
  description = "Determines whether the ALB is internal or internet facing"
  type        = bool
}

variable "backend_port" {
  description = "value of the backend port"
  type        = number
}

variable "backend_protocol" {
  description = "value of the backend protocol"
  type        = string
}

variable "target_group_index" {
  description = "value of the target group index"
  type        = number
}

variable "target_type" {
  description = "target type for load balancer"
  type        = string
}

##################################
###         s3           ##
##################################

variable "enabled" {
  description = "Determines whether the S3 bucket versioning is enabled"
  type        = bool
  default     = false
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

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = null
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

#####################################################
##  AWS Backup                                      #
#####################################################
variable "rule_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job"
  type        = string
  default     = ""
}
variable "rule_start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = string
  default     = ""
}
variable "rule_completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error"
  type        = string
  default     = ""
}
