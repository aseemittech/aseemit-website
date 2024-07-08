locals {
  region = var.region
  tags = {
    Environment = var.environment
    Region      = var.region
    Application = local.app_name
    client      = local.client
    terraform   = true
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

  # naming convention
  app_name       = "aseemit"
  project_prefix = "asm"
  client         = "aseemit"
  environment    = var.environment
  common_naming = {
    app_name_short = "asem"
  }

  frontend_naming = {
    app_name_short = "asft"
  }

  backend_naming = {
    app_name_short = "asbk"
  }

  # VPC
  vpc = {
    vpc_name                = module.common_naming.resources.vpc.name
    vpc_cidr                = var.vpc_cidr
    azs                     = slice(data.aws_availability_zones.available.names, 0, var.number_of_azs)
    security_group_backend  = "${var.environment}-${local.app_name}-backend-sg"
    security_group_frontend = "${var.environment}-${local.app_name}-frontend-sg"
  }

  iam = {
    iam_instance_profile = "${local.app_name}-AseemitEc2InstanceProfile"
  }

  backup = {
    vault_name             = "${local.app_name}_backup_vault"
    plan_name              = "${local.app_name}_backup_plan"
    rule_name              = "${local.app_name}_backup_rule"
    destination_vault_name = "${local.app_name}_destination_backup_vault"
  }

  ec2 = {
    ec2_name               = module.backend_naming.resources.ec2.name
    instance_type          = var.instance_type
    subnet_id              = module.vpc.private_subnets[0]
    vpc_security_group_ids = [aws_security_group.backend.id]
    iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
    iam_role_name          = aws_iam_role.ec2_iam_role.name
    ec2_ami                = var.ec2_ami
  }

  # Application Load Balancer
  alb = {
    alb_name          = module.frontend_naming.resources.alb.name
    vpc_id            = module.vpc.vpc_id
    public_subnets    = module.vpc.public_subnets
    target_group_name = "${var.environment}-${local.app_name}-alb-tg"

    enable_cross_zone_load_balancing = false
    enable_deletion_protection       = false

    internal           = var.internal
    backend_port       = var.backend_port
    backend_protocol   = var.backend_protocol
    action_type        = "redirect"
    target_group_index = var.target_group_index
    target_type        = var.target_type
    # certificate_arn                  = data.aws_acm_certificate.issued.arn
    redirect_status_code = "HTTP_301"
    redirect_protocol    = "HTTPS"
    redirect_port        = 443
    target_group_index   = 0
  }

  log_bucket = {
    bucket_name                    = "${module.frontend_naming.resources.s3.name}-log-bucket"
    acl                            = "log-delivery-write"
    force_destroy                  = true
    control_object_ownership       = true
    object_ownership               = "ObjectWriter"
    target_prefix                  = "log/"
    block_public_acls              = true
    block_public_policy            = true
    attach_elb_log_delivery_policy = true
    attach_lb_log_delivery_policy  = true
    enabled                        = var.enabled
  }

  codebase_bucket = {
    bucket_name = "${module.common_naming.resources.s3.name}-codebase"
    enabled     = var.enabled
  }

  rds = {
    identifier                          = module.common_naming.resources.rds.name
    parameter_group_name                = "${var.environment}-${local.app_name}-pg"
    monitoring_role_name                = "${var.environment}-${local.app_name}-monitoring-role"
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

    # Tags
    data_type = "sensitive"
    layerid   = "db"
    stack     = "database"
  }

  route53 = {
    hosted_zone_name = "pranishweb.com"
  }

  sns = {
    topic_name      = module.common_naming.resources.sns.name
    fifo_topic      = false
    use_name_prefix = var.use_name_prefix
    subscriptions   = var.subscriptions
  }

  metric_widget = {
    region                = "us-east-1"
    x_axis_asg            = 6
    y_axis_asg            = 24
    width_asg             = 6
    height_asg            = 6
    metrics_namespace_asg = ["AWS/EC2", "AWS/AutoScaling"]
    resource_name_asg     = "AutoScalingGroupName"
    metrics_name_asg_gis  = "GroupInServiceInstances"
    metrics_name_asg_gti  = "GroupTerminatingInstances"
    metrics_name_asg_gms  = "GroupMaxSize"
    metrics_name_asg_gmis = "GroupMinSize"
    cpu_metric_ec2        = "CpuUtilization"

    period_asg = 300
    stat_asg   = "Average"
    title_asg  = "Autoscaling"
  }

  log_widgets = {
    region = "us-east-1"
    x_axis = 6
    y_axis = 24
    width  = 6
    height = 6
  }

  secrets = {
    name_prefix             = "${module.common_naming.resources.prefix.name}-secret1"
    description             = "Secrets Manager secret for RDS database"
    ignore_secret_changes   = true
    enable_rotation         = var.enable_rotation
    recovery_window_in_days = var.recovery_window_in_days
  }

  # cpu-alarm-backend = {
  #   alarm_name          = "${local.app_name}-${var.environment}-cpu-alm"
  #   comparison_operator = "GreaterThanOrEqualToThreshold"
  #   evaluation_periods  = 1
  #   metric_name         = "CPUUtilization"
  #   namespace           = "AWS/EC2"
  #   period              = 10
  #   statistic           = "Average"
  #   threshold           = 80
  #   treat_missing_data  = "notBreaching"
  #   alarm_description   = "CPU utilization monitoring alarms for back"
  #   dimensions = {
  #     AutoScalingGroupName = module.asg.autoscaling_group_name
  #   }
  #   alarm_actions = [module.sns.topic_arn, "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:opsitem:${local.severity.critical}#CATEGORY=${local.category.cost}", aws_autoscaling_policy.target_back.arn]
  # }

  # status_check_alarm_back = {
  #   alarm_name          = "${local.app_name}-${var.environment}-status-fail"
  #   comparison_operator = "GreaterThanOrEqualToThreshold"
  #   evaluation_periods  = "2"
  #   metric_name         = "StatusCheckFailed_Instance"
  #   namespace           = "AWS/EC2"
  #   period              = "300" // 5 minutes
  #   statistic           = "Sum"
  #   threshold           = "1"
  #   alarm_description   = "Alarm for status check"
  #   treat_missing_data  = "notBreaching"
  #   dimensions = {
  #     AutoScalingGroupName = module.asg.autoscaling_group_name
  #   }
  #   alarm_actions = [module.sns.topic_arn]
  # }
}
