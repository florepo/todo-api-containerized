resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.default_tags,
    {
      Name      = "VPC"
    }
  )
}

resource "aws_subnet" "public-alb-a" {
  availability_zone       = "eu-west-3a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  vpc_id = aws_vpc.default.id

  tags = merge(local.default_tags,
    {
      Name      = "ALB Subnet West-3a"
    }
  )
}

resource "aws_subnet" "public-alb-b" {
  availability_zone       = "eu-west-3b"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  vpc_id = aws_vpc.default.id

  tags = {
    Env  = "production"
    Name = "public-todos-api"
  }
}

# Create subnets for the clusters
resource "aws_subnet" "ecs_subnet_a" {
  availability_zone = "eu-west-3a"
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.default.id
  map_public_ip_on_launch = true
  tags = {
    Name = "ecs_subnet_3a"
    Application = "todos-api"
  }
}

resource "aws_subnet" "ecs_subnet_b" {
  availability_zone = "eu-west-3b"
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.default.id
  map_public_ip_on_launch = true
  tags = {
    Name = "ecs_subnet_3b"
    Application = "todos-api"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Env  = "production"
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "public" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Env  = "production"
    Name = "route-table-public"
  }

  vpc_id = aws_vpc.default.id
}

resource "aws_route_table_association" "public-alb-a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public-alb-a.id
}

resource "aws_route_table_association" "public-alb-b" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public-alb-b.id
}

resource "aws_main_route_table_association" "default" {
  route_table_id = aws_route_table.public.id
  vpc_id         = aws_vpc.default.id
}
