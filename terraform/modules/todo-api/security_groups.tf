resource "aws_security_group" "ingress_http" {
  name        = "ingress_http"
  description = "HTTP traffic"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags,
    {
      Name      = "Ingress TCP 80"
    }
  )
}

resource "aws_security_group" "egress_all" {
  name        = "egress_all"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags,
    {
      Name      = "Egress ALL"
    }
  )
}

resource "aws_security_group" "ingress_api" {
  name        = "ingress_api"
  description = "Allow ingress to API"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.default_tags,
    {
      Name      = "Ingress TCP 3000"
    }
  )
}

# resource "aws_security_group" "https" {
#   name        = "https"
#   description = "HTTPS traffic"
#   vpc_id      = aws_vpc.default.id

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = merge(local.default_tags,
#     {
#       Name      = "Ingress TCP 80"
#     }
#   )
# }



# ALB Security Group (Traffic Internet -> ALB)
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
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags,
    {
      Name      = "ALB Security Group"
    }
  )
}

# ECS Security group (traffic ALB -> ECS, ssh -> ECS)
# resource "aws_security_group" "ecs_tasks" {
#   name        = "ecs_tasks_sg"
#   description = "allow inbound access from the ALB only"
#   vpc_id      = aws_vpc.default.id

#   ingress {
#     from_port       = 0
#     to_port         = 0
#     protocol        = "-1"
#     security_groups = [aws_security_group.alb.id]
#   }
  

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # ingress {
#   #   protocol        = "tcp"
#   #   from_port       = 3000
#   #   to_port         = 3000
#   #   cidr_blocks     = ["0.0.0.0/0"]
#   #   security_groups = [aws_security_group.alb.id]
#   # }
#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = merge(local.default_tags,
#     {
#       Name      = "ECS Security Group"
#     }
#   )
# }
