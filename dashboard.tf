module "metric_widgets" {
  source = "./modules/dashboard/formater/metrics"

  widgets = [
    {
      type   = "metric"
      x      = local.metric_widget.x_axis_asg
      y      = local.metric_widget.y_axis_asg
      width  = local.metric_widget.width_asg
      height = local.metric_widget.height_asg
      metrics = [
        [local.metric_widget.metrics_namespace_asg[1], local.metric_widget.metrics_name_asg_gis,
        local.metric_widget.resource_name_asg, module.asg.autoscaling_group_id],
        [local.metric_widget.metrics_namespace_asg[1], local.metric_widget.metrics_name_asg_gti,
        local.metric_widget.resource_name_asg, module.asg.autoscaling_group_id],
        [local.metric_widget.metrics_namespace_asg[1], local.metric_widget.metrics_name_asg_gms,
        local.metric_widget.resource_name_asg, module.asg.autoscaling_group_id],
        [local.metric_widget.metrics_namespace_asg[1], local.metric_widget.metrics_name_asg_gmis,
        local.metric_widget.resource_name_asg, module.asg.autoscaling_group_id],
        [local.metric_widget.metrics_namespace_asg[0], local.metric_widget.cpu_metric_ec2,
        local.metric_widget.resource_name_asg, module.asg.autoscaling_group_id],
      ]
      period = local.metric_widget.period_asg
      stat   = local.metric_widget.stat_asg
      region = local.metric_widget.region
      title  = local.metric_widget.title_asg
    }
  ]
}

module "log_widgets" {
  source = "./modules/dashboard/formater/logs"

  widgets = [
    {
      type   = "log"
      x      = local.log_widgets.x_axis
      y      = local.log_widgets.y_axis
      width  = local.log_widgets.width
      height = local.log_widgets.height
      region = local.log_widgets.region
      title  = "RDS Error log"
      query  = "SOURCE '${tostring(module.rds.db_instance_cloudwatch_log_groups["error"]["name"])}' | fields @timestamp, @message, @logStream, @log | sort @timestamp desc | limit 20"
    },
    // Add more log widgets as needed
  ]
}

module "dashboard" {
  source = "./modules/dashboard"

  dashboard_name = "sdTech_wordpress_asg"
  dashboard_body = jsonencode({
    widgets = concat(
      module.metric_widgets.widget_templates,
      module.log_widgets.widget_templates
    )
  })
}
