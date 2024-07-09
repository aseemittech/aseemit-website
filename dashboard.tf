module "metric_widgets" {
  source = "./modules/dashboard/formater/metrics"

  widgets = [
    {
      type   = "metric"
      x      = 20
      y      = 0
      width  = 12
      height = 6
      metrics = [
        ["AWS/EC2", "CPUUtilization", "InstanceId", "${module.ec2.id}"],
        ["AWS/EC2", "DiskReadOps", "InstanceId", "${module.ec2.id}"]
      ]
      period = 300
      stat   = "Average"
      region = local.region
      title  = "EC2 Instance CPU"
    },
    {
      type   = "metric"
      x      = 20
      y      = 0
      width  = 12
      height = 6
      metrics = [
        ["AWS/ApplicationELB", "ProcessedBytes", "LoadBalancer", "app/k8s-default-frontend-6ed5154731/3b420e4a58634cf6"]
      ]
      period = 300
      stat   = "Average"
      region = local.region
      title  = "EC2 Instance CPU"
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

  dashboard_name = "aseemittech"
  dashboard_body = jsonencode({
    widgets = concat(
      module.metric_widgets.widget_templates,
    )
  })
}
