locals {
  region = var.region
  asset_bucket = {
    bucket_name              = module.naming.resources.s3.name
    target_prefix            = "assets/"
    enabled                  = var.versioning_enabled
    block_public_policy      = var.block_public_policy
    block_public_acls        = var.block_public_acls
    control_object_ownership = var.control_object_ownership
  }
  vpc = {
    vpc_name = module.naming.resources.vpc.name
    vpc_cidr = var.vpc_cidr
    azs      = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
  }
  tags = {
    Region = var.region
  }

  rds = {
    identifier                          = module.naming.resources.rds.name
    parameter_group_name                = "${module.naming.resources.prefix.name}-pg"
    monitoring_role_name                = "${module.naming.resources.prefix.name}-monitoring-role"
    engine                              = "mysql"
    family                              = "mysql8.0"
    engine_version                      = "8.0"
    port                                = "3306"
    data_type                           = "sensitive"
    layerid                             = "db"
    stack                               = "database"
    enabled_cloudwatch_logs_exports     = ["error"]
    retention_in_days                   = 7
    apply_immediately                   = true
    performance_insights_enabled        = true
    create_cloudwatch_log_group         = true
    skip_final_snapshot                 = false
    publicly_accessible                 = false
    create_db_subnet_group              = false
    create_db_option_group              = false
    iam_database_authentication_enabled = true
    parameter_group_use_name_prefix     = false

    db_name                 = var.db_name
    instance_class          = var.instance_class
    allocated_storage       = var.allocated_storage
    username                = var.username
    multi_az                = var.multi_az
    deletion_protection     = var.deletion_protection
    create_random_password  = var.create_random_password
    backup_retention_period = var.backup_retention_period
    monitoring_interval     = var.monitoring_interval
    create_monitoring_role  = var.create_monitoring_role
    major_engine_version    = var.major_engine_version
  }

  ec2 = {
    ec2_name               = module.naming.resources.ec2.name
    instance_type          = var.instance_type
    subnet_id              = module.vpc.public_subnets[0]
    vpc_security_group_ids = [aws_security_group.ec2.id]
    iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
    iam_role_name          = aws_iam_role.ec2_iam_role.name
    ec2_ami                = var.ec2_ami
  }

  secrets = {
    name_prefix             = "${module.naming.resources.prefix.name}-secret1"
    description             = "Secrets Manager secret for RDS database"
    ignore_secret_changes   = true
    enable_rotation         = var.enable_rotation
    recovery_window_in_days = var.recovery_window_in_days
  }

  sns = {
    topic_name      = module.naming.resources.sns.name
    fifo_topic      = false
    use_name_prefix = var.use_name_prefix
    subscriptions   = var.subscriptions
  }

  status_check_alarm = {
    alarm_name          = "${module.naming.resources.ec2.name}-status-fail-front"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "StatusCheckFailed_Instance"
    namespace           = "AWS/EC2"
    period              = "300" // 5 minutes
    statistic           = "Sum"
    threshold           = "1"
    alarm_description   = "Alarm for statuc check"
    treat_missing_data  = "notBreaching"
    alarm_actions       = ["${module.sns.aws_sns_topic_arn}"]
  }

  cpu-alarm = {
    alarm_name          = "${module.naming.resources.ec2.name}-cpu-alm-frontend"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = 1
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 10
    statistic           = "Average"
    threshold           = 80
    treat_missing_data  = "notBreaching"
    alarm_description   = "CPU utilization monitoring alarms for back"
    alarm_actions       = ["${module.sns.aws_sns_topic_arn}"]
  }



  log_widgets = {
    region = "ap-south-1"
    x_axis = 6
    y_axis = 24
    width  = 6
    height = 6
  }

  severity = {
    critical = "1"
    high     = "2"
    medium   = "3"
    low      = "4"
  }

  category = {
    availability = "Availability"
    cost         = "Cost"
    performance  = "Performance"
    recovery     = "Recovery"
    security     = "Security"
  }
}
