# ============================================================
# ALB Security Group
# ============================================================

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Security group for ${var.project_name} ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from internet"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from internet"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# Application Load Balancer
# ============================================================

resource "aws_lb" "this" {
  name = "${var.project_name}-${var.environment}-alb"

  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-alb"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# Target Group
# ============================================================

resource "aws_lb_target_group" "this" {
  name = "${var.project_name}-${var.environment}-tg"

  port     = var.container_port
  protocol = "HTTP"

  # IMPORTANT:
  # Fargate + awsvpc requires IP target type.
  target_type = "ip"

  vpc_id = var.vpc_id

  health_check {
    enabled = true

    protocol = "HTTP"

    path = var.health_check_path

    port = "traffic-port"

    healthy_threshold = 3

    unhealthy_threshold = 3

    timeout = 5

    interval = 30

    matcher = "200"
  }

  deregistration_delay = 30

  tags = {
    Name        = "${var.project_name}-${var.environment}-tg"
    Project     = var.project_name
    Environment = var.environment
  }
}


# ============================================================
# HTTP Listener
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port = 80

  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port = "443"

      protocol = "HTTPS"

      status_code = "HTTP_301"
    }
  }
}


# ============================================================
# HTTPS Listener
# ============================================================

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn

  port = 443

  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = var.certificate_arn

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn
  }
}