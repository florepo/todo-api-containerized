resource "aws_default_vpc" "default_vpc" {
}


# Providing a reference to our default subnets
resource "aws_subnet" "ecs_subnet_a" {
  availability_zone = "eu-west-3a"
  cidr_block = "172.31.3.0/24"
  vpc_id = aws_default_vpc.default_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "ecs_subnet_3a"
  }
}

resource "aws_subnet" "ecs_subnet_b" {
  availability_zone = "eu-west-3b"
  cidr_block = "172.31.4.0/24"
  vpc_id = aws_default_vpc.default_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "ecs_subnet_3b"
  }
}

