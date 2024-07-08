output "widget_templates" {
  description = "A list of templates for CloudWatch dashboard widgets."

  value = [
    for widget in var.widgets :
    {
      type   = widget.type
      x      = widget.x
      y      = widget.y
      width  = widget.width
      height = widget.height
      properties = {
        region = widget.region
        title  = widget.title
        query  = widget.query
      }
    }
  ]
}
