############################################################
#Module sources for RDS#
############################################################
module "rds" {
  source = "./modules/rds"

  identifier                             = local.rds.identifier
  parameter_group_name                   = local.rds.parameter_group_name
  monitoring_role_name                   = local.rds.monitoring_role_name
  engine                                 = local.rds.engine
  engine_version                         = local.rds.engine_version
  family                                 = local.rds.family
  port                                   = local.rds.port
  enabled_cloudwatch_logs_exports        = local.rds.enabled_cloudwatch_logs_exports
  cloudwatch_log_group_retention_in_days = local.rds.retention_in_days
  apply_immediately                      = local.rds.apply_immediately
  performance_insights_enabled           = local.rds.performance_insights_enabled
  create_cloudwatch_log_group            = local.rds.create_cloudwatch_log_group
  skip_final_snapshot                    = local.rds.skip_final_snapshot
  publicly_accessible                    = local.rds.publicly_accessible
  create_db_subnet_group                 = local.rds.create_db_subnet_group
  create_db_option_group                 = local.rds.create_db_option_group
  iam_database_authentication_enabled    = local.rds.iam_database_authentication_enabled
  parameter_group_use_name_prefix        = local.rds.parameter_group_use_name_prefix
  manage_master_user_password            = local.rds.manage_master_user_password
  manage_master_user_password_rotation   = false

  db_name                 = local.rds.db_name
  instance_class          = local.rds.instance_class
  allocated_storage       = local.rds.allocated_storage
  username                = local.rds.username
  multi_az                = local.rds.multi_az
  deletion_protection     = local.rds.deletion_protection
  backup_retention_period = local.rds.backup_retention_period
  monitoring_interval     = local.rds.monitoring_interval
  create_monitoring_role  = local.rds.create_monitoring_role
  major_engine_version    = local.rds.major_engine_version

  subnet_ids             = [for subnet_id in module.vpc.private_subnets : subnet_id]
  vpc_security_group_ids = [aws_security_group.database.id]
  db_subnet_group_name   = module.vpc.database_subnet_group

  tags = {
    Name    = local.rds.identifier
    data    = local.rds.data_type
    layerid = local.rds.layerid
    stack   = local.rds.stack
  }
}
