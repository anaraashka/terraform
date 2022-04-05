# Create a VPC
resource "aws_vpc" "Panasonic" {
    tags = {
     Name = var.tag
   }
  cidr_block = var.vpc_cidr_b
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.Panasonic.id
  cidr_block = var.pub_subnet_cidr

  tags = {
    Name = "${var.tag}-Public-Subnet1"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.Panasonic.id
  cidr_block = var.pri_subnet_cidr

  tags = {
    Name = "${var.tag}-Private-Subnet1"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Panasonic.id

  tags = {
    Name = "${var.tag}-GW"
  }
}

# Public route table
resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.Panasonic.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.tag}-Public-RT"
  }
}

# Add tag to the Main Route Table
resource "aws_default_route_table" "private-RT" {
  default_route_table_id = "${aws_vpc.Panasonic.default_route_table_id}"

  tags = {
    Name = "${var.tag}-Private-RT"
  }
}

# Route Table Assoiciation with Public
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.Public-RT.id
}

# Route Table Assoiciation with Private
resource "aws_route_table_association" "b" {
#  subnet_id      = "${aws_subnet.private_subnet.id}"
#  route_table_id = "${aws_route_table.private-RT.id}"

  subnet_id      = aws_subnet.private_subnet.id 
  route_table_id = aws_default_route_table.private-RT.id
}