output "widget_templates" {
  description = "A list of templates for CloudWatch dashboard metric widgets."

  value = [
    for widget in var.widgets :
    {
      type   = widget.type
      x      = widget.x
      y      = widget.y
      width  = widget.width
      height = widget.height
      properties = {
        metrics = widget.metrics
        period  = widget.period
        stat    = widget.stat
        region  = widget.region
        title   = widget.title
      }
    }
  ]
}
