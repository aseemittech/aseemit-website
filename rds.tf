############################################################
#Module sources for RDS#
############################################################
module "rds" {
  source                                 = "./modules/rds"
  identifier                             = local.rds.identifier
  engine                                 = local.rds.engine
  engine_version                         = local.rds.engine_version
  instance_class                         = local.rds.instance_class
  allocated_storage                      = local.rds.allocated_storage
  db_name                                = local.rds.db_name
  username                               = local.rds.username
  family                                 = local.rds.family
  major_engine_version                   = local.rds.major_engine_version
  port                                   = local.rds.port
  multi_az                               = local.rds.multi_az
  create_random_password                 = local.rds.create_random_password
  backup_retention_period                = local.rds.backup_retention_period
  create_cloudwatch_log_group            = local.rds.create_cloudwatch_log_group
  subnet_ids                             = [for subnet_id in module.vpc.database_subnets : subnet_id]
  vpc_security_group_ids                 = [aws_security_group.database.id]
  deletion_protection                    = local.rds.deletion_protection
  create_db_subnet_group                 = local.rds.create_db_subnet_group
  create_db_option_group                 = local.rds.create_db_option_group
  db_subnet_group_name                   = module.vpc.database_subnet_group
  performance_insights_enabled           = local.rds.performance_insights_enabled
  parameter_group_name                   = local.rds.parameter_group_name
  parameter_group_use_name_prefix        = local.rds.parameter_group_use_name_prefix
  publicly_accessible                    = local.rds.publicly_accessible
  iam_database_authentication_enabled    = local.rds.iam_database_authentication_enabled
  skip_final_snapshot                    = local.rds.skip_final_snapshot
  create_monitoring_role                 = local.rds.create_monitoring_role
  monitoring_role_name                   = local.rds.monitoring_role_name
  monitoring_interval                    = local.rds.monitoring_interval
  enabled_cloudwatch_logs_exports        = local.rds.enabled_cloudwatch_logs_exports
  cloudwatch_log_group_retention_in_days = local.rds.retention_in_days
  apply_immediately                      = local.rds.apply_immediately
  tags = {
    Name    = local.rds.identifier
    data    = local.rds.data_type
    layerid = local.rds.layerid
    stack   = local.rds.stack
  }

}
