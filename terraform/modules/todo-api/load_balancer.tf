resource "aws_security_group" "alb" {
  name        = "alb_sg"
  description = "controls access to the Application Load Balancer (ALB)"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "ecs_tasks_sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol        = "tcp"
    from_port       = 4000
    to_port         = 4000
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb.id]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "production" {
  name               = "alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public-alb-a.id, aws_subnet.public-alb-b.id]
  security_groups    = [aws_security_group.alb.id]

  tags = {
    Environment = "production"
    Application = "todosapi"
  }
}

resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = aws_lb.production.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.production.arn
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
