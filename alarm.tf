module "status-check-alarm" {
  source              = "./modules/alarm"
  region              = var.region
  alarm_name          = local.status_check_alarm.alarm_name
  comparison_operator = local.status_check_alarm.comparison_operator
  evaluation_periods  = local.status_check_alarm.evaluation_periods
  metric_name         = local.status_check_alarm.metric_name
  namespace           = local.status_check_alarm.namespace
  period              = local.status_check_alarm.period
  statistic           = local.status_check_alarm.statistic
  threshold           = local.status_check_alarm.threshold
  alarm_description   = local.status_check_alarm.alarm_description
  treat_missing_data  = local.status_check_alarm.treat_missing_data
  alarm_actions       = local.status_check_alarm.alarm_actions
  tags                = merge(local.tags, { "Name" = local.status_check_alarm.alarm_name })
}

module "cpu-alarm" {
  source              = "./modules/alarm"
  region              = var.region
  alarm_name          = local.cpu-alarm.alarm_name
  comparison_operator = local.cpu-alarm.comparison_operator
  evaluation_periods  = local.cpu-alarm.evaluation_periods
  metric_name         = local.cpu-alarm.metric_name
  namespace           = local.cpu-alarm.namespace
  period              = local.cpu-alarm.period
  statistic           = local.cpu-alarm.statistic
  threshold           = local.cpu-alarm.threshold
  alarm_description   = local.cpu-alarm.alarm_description
  treat_missing_data  = local.cpu-alarm.treat_missing_data
  alarm_actions       = local.cpu-alarm.alarm_actions
  tags                = merge(local.tags, { "Name" = local.cpu-alarm.alarm_name })
}
