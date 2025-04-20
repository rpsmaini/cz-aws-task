resource "aws_vpc" "cz-vpc" {
  cidr_block           = "10.8.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "cz-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cz-vpc.id

  tags = {
    Name = "cz-igw"
  }
}

resource "aws_subnet" "sbnt-pb-1" {
  vpc_id = aws_vpc.cz-vpc.id
  cidr_block = "10.8.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "cz-sbnt-pb-1"
  }
}

resource "aws_subnet" "sbnt-pb-2" {
  vpc_id = aws_vpc.cz-vpc.id
  cidr_block = "10.8.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "cz-sbnt-pb-2"
  }
}

resource "aws_subnet" "sbnt-pr-1" {
  vpc_id = aws_vpc.cz-vpc.id
  cidr_block = "10.8.101.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "cz-sbnt-pr-1"
  }
}

resource "aws_subnet" "sbnt-pr-2" {
  vpc_id = aws_vpc.cz-vpc.id
  cidr_block = "10.8.102.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "cz-sbnt-pr-2"
  }
}
#public route tables
resource "aws_route_table" "cz-rtbl-pb" {
  vpc_id = aws_vpc.cz-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "cz-rtbl-pb"
  }
}
#public association
resource "aws_route_table_association" "cz-rtbl-pb-1" {
  subnet_id      = aws_subnet.sbnt-pb-1.id
  route_table_id = aws_route_table.cz-rtbl-pb.id
}

resource "aws_route_table_association" "cz-rtbl-pb-2" {
  subnet_id      = aws_subnet.sbnt-pb-2.id
  route_table_id = aws_route_table.cz-rtbl-pb.id
}

#private route tables
resource "aws_route_table" "cz-rtbl-pr" {
  vpc_id = aws_vpc.cz-vpc.id
  tags = {
    Name = "cz-rtbl-pr"
  }
}
resource "aws_route_table_association" "cz-rtbl-pr-1" {
  subnet_id      = aws_subnet.sbnt-pr-1.id
  route_table_id = aws_route_table.cz-rtbl-pr.id
}

resource "aws_route_table_association" "cz-rtbl-pr-2" {
  subnet_id      = aws_subnet.sbnt-pr-2.id
  route_table_id = aws_route_table.cz-rtbl-pr.id
}
#map_public_ip_on_launch = true added when ec2 or alb in pubsbnet get ip
