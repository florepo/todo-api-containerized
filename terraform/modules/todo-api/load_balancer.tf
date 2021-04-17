resource "aws_lb" "production" {
  name               = "alb"
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public-alb-a.id,
    aws_subnet.public-alb-b.id
  ]
  security_groups   = [
    aws_security_group.ingress_http.id,
    aws_security_group.ingress_api.id,
    aws_security_group.egress_all.id,
  ]

  tags = merge(local.default_tags,
    {
      Name      = "ALB"
    }
  )
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.production.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.production.id
  }
}

resource "aws_lb_target_group" "production" {
  name        = "todos-api-alb-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.default.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = "20"
    path                = "/"
    unhealthy_threshold = "2"
  }
  depends_on = [aws_lb.production]

  tags = merge(local.default_tags,
    {
      Name      = "ALB Target Group"
    }
  )
}
