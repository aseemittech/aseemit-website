############################################################
#########      elasticache Configuration          ##########
############################################################
module "cpu-alarm-backend-alarm" {
  source              = "./modules/alarm"
  region              = var.region
  alarm_name          = local.cpu-alarm-backend.alarm_name
  comparison_operator = local.cpu-alarm-backend.comparison_operator
  evaluation_periods  = local.cpu-alarm-backend.evaluation_periods
  metric_name         = local.cpu-alarm-backend.metric_name
  namespace           = local.cpu-alarm-backend.namespace
  period              = local.cpu-alarm-backend.period
  statistic           = local.cpu-alarm-backend.statistic
  threshold           = local.cpu-alarm-backend.threshold
  alarm_description   = local.cpu-alarm-backend.alarm_description
  dimensions          = local.cpu-alarm-backend.dimensions
  treat_missing_data  = local.cpu-alarm-backend.treat_missing_data
  alarm_actions       = local.cpu-alarm-backend.alarm_actions
}

module "status-check-alarm-back" {
  source              = "./modules/alarm"
  region              = var.region
  alarm_name          = local.status_check_alarm_back.alarm_name
  comparison_operator = local.status_check_alarm_back.comparison_operator
  evaluation_periods  = local.status_check_alarm_back.evaluation_periods
  metric_name         = local.status_check_alarm_back.metric_name
  namespace           = local.status_check_alarm_back.namespace
  period              = local.status_check_alarm_back.period
  statistic           = local.status_check_alarm_back.statistic
  threshold           = local.status_check_alarm_back.threshold
  alarm_description   = local.status_check_alarm_back.alarm_description
  dimensions          = local.status_check_alarm_back.dimensions
  treat_missing_data  = local.status_check_alarm_back.treat_missing_data
  alarm_actions       = local.status_check_alarm_back.alarm_actions
}
