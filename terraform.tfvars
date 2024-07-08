##Variables for tagging.
region = "ap-south-1"

## Variables for naming conventions .
environment = "development"

## Variables for VPC
vpc_cidr      = "10.0.0.0/20"
number_of_azs = 2

## Variables for ALB
internal           = false
backend_port       = 80
backend_protocol   = "HTTP"
target_group_index = 0
target_type        = "instance"

# Variable for s3
enabled = true

## Variable for RDS
db_name                 = "aseemit"
instance_class          = "db.t3.micro"
username                = "aseem"
monitoring_interval     = "10"
major_engine_version    = "8.0"
allocated_storage       = 100
backup_retention_period = 1
multi_az                = false
deletion_protection     = true
create_random_password  = true
create_monitoring_role  = true

## variables for ec2
ec2_ami       = "ami-0c2af51e265bd5e0e"
instance_type = "t3.xlarge"
# instance_type = "t2.micro"

hibernation                 = true
associate_public_ip_address = true
disable_api_stop            = true
create_iam_instance_profile = true
monitoring                  = true
user_data_replace_on_change = false
user_data                   = <<-EOT
    #!/bin/bash
    sudo apt-get update -y
    sudo apt install zip unzip curl git jq -y
EOT
root_volume_type            = "gp3"
root_volume_size            = 50
root_throughput             = 200

# Variable for SNS
use_name_prefix = true
subscriptions = {
  email = {
    protocol = "email",
    endpoint = "mukesh.awasthi@adex.ltd"
  }
}

### AWS Backup Vault
rule_schedule          = "cron(0 * * * ? *)"
rule_start_window      = "60"
rule_completion_window = "120"
