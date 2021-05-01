resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example_vpc"
  }
}


//マルチAZ
resource "aws_subnet" "example_public_subnet_0" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1a"
}
//マルチAZ
resource "aws_subnet" "example_public_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-1c"
}


resource "aws_internet_gateway" "example_internet_gateway" {
  vpc_id = aws_vpc.example_vpc.id
}

#ルートテーブル
resource "aws_route_table" "example_vpc_table" {
  vpc_id = aws_vpc.example_vpc.id
}

#マルチ
resource "aws_route_table" "example_vpc_table_private_0" {
  vpc_id = aws_vpc.example_vpc.id
}
#マルチ
resource "aws_route_table" "example_vpc_table_private_1" {
  vpc_id = aws_vpc.example_vpc.id
}

#public 
#ルート
#ルートテーブル
#gateway
resource "aws_route" "example_route" {
  route_table_id         = aws_route_table.example_vpc_table.id
  gateway_id             = aws_internet_gateway.example_internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

#マルチ
resource "aws_route_table_association" "example_public_route_0" {
  route_table_id = aws_route_table.example_vpc_table.id
  subnet_id      = aws_subnet.example_public_subnet_0.id
}
#マルチ
resource "aws_route_table_association" "example_public_route_1" {
  route_table_id = aws_route_table.example_vpc_table.id
  subnet_id      = aws_subnet.example_public_subnet_1.id
}


//マルチprivate
resource "aws_subnet" "example_private_subnet_0" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.65.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1a"
}
//マルチprivate
resource "aws_subnet" "example_private_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.66.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-northeast-1c"
}


//マルチprivate
resource "aws_route_table_association" "example_private_subnet_table_0" {
  route_table_id = aws_route_table.example_vpc_table_private_0.id
  subnet_id      = aws_subnet.example_private_subnet_0.id
}
//マルチprivate
resource "aws_route_table_association" "example_private_subnet_table_1" {
  route_table_id = aws_route_table.example_vpc_table_private_1.id
  subnet_id      = aws_subnet.example_private_subnet_1.id
}

//マルチ
#静的IPアドレス
resource "aws_eip" "nat_gateway_0" {
  vpc = true
  depends_on = [
    aws_internet_gateway.example_internet_gateway
  ]
}

//マルチ
resource "aws_eip" "nat_gateway_1" {
  vpc = true
  depends_on = [
    aws_internet_gateway.example_internet_gateway
  ]
}

//マルチ
resource "aws_nat_gateway" "example_nat_gateway_0" {
  allocation_id = aws_eip.nat_gateway_0.id
  subnet_id     = aws_subnet.example_public_subnet_0.id
  depends_on = [
    aws_internet_gateway.example_internet_gateway
  ]
}
//マルチ
resource "aws_nat_gateway" "example_nat_gateway_1" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.example_public_subnet_1.id
  depends_on = [
    aws_internet_gateway.example_internet_gateway
  ]
}



#private subet route
resource "aws_route" "example_route_private_0" {
  route_table_id         = aws_route_table.example_vpc_table_private_0.id
  nat_gateway_id         = aws_nat_gateway.example_nat_gateway_0.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "example_route_private_1" {
  route_table_id         = aws_route_table.example_vpc_table_private_1.id
  nat_gateway_id         = aws_nat_gateway.example_nat_gateway_1.id
  destination_cidr_block = "0.0.0.0/0"
}
