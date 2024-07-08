module "alb" {
  source = "./modules/elb"

  name                             = local.alb.alb_name
  vpc_id                           = local.alb.vpc_id
  subnets                          = local.alb.public_subnets
  internal                         = local.alb.internal
  enable_cross_zone_load_balancing = local.alb.enable_cross_zone_load_balancing
  enable_deletion_protection       = local.alb.enable_deletion_protection

  access_logs = {
    enabled = true
    bucket  = module.log_bucket.s3_bucket_id
  }

  # Security Group
  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress_all_https = {
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  http_tcp_listeners = [
    {
      port               = local.alb.backend_port
      protocol           = local.alb.backend_protocol
      target_group_index = local.alb.target_group_index
      # action_type = local.alb.action_type

      # redirect = {
      #   port        = local.alb.redirect_port
      #   protocol    = local.alb.redirect_protocol
      #   status_code = local.alb.redirect_status_code
      # }
    }
  ]

  # https_listeners = [
  #   {
  #     port               = local.alb.redirect_port
  #     protocol           = local.alb.redirect_protocol
  #     certificate_arn    = local.alb.certificate_arn
  #     target_group_index = local.alb.target_group_index
  #   }
  # ]

  target_groups = [
    {
      name             = local.alb.target_group_name
      backend_protocol = local.alb.backend_protocol
      backend_port     = local.alb.backend_port
      target_type      = local.alb.target_type
      health_check     = { enabled = true, path = "/" }
    }
  ]

}
