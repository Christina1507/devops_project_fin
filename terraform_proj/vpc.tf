resource "aws_vpc" "projvpc" {
  cidr_block       = "11.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "projvpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.projvpc.id
  cidr_block        = "11.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.projvpc.id
  cidr_block        = "11.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.projvpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.projvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "rt_associate1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rt_associate2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.route_table.id
}
