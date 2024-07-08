#################################################
# Resources defination for sg
#################################################
resource "aws_security_group" "database" {
  description = "Security group for database"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }
}
### Backend application security group
resource "aws_security_group" "backend" {
  name_prefix = local.vpc.security_group_backend
  description = "Security group for backend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "Input from frontend security group to backend"
    from_port       = 1880
    to_port         = 1880
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
    cidr_blocks     = [module.vpc.vpc_cidr_block]
  }

  ingress {
    description     = "HTTP ingress"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }
  ingress {
    description     = "http ingress"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }

  egress {
    description = "output tcp to public"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Frontend application security group

resource "aws_security_group" "frontend" {
  name_prefix = local.vpc.security_group_frontend
  description = "Security group for frontend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "http ingress"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }
  ingress {
    description     = "https ingress"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
