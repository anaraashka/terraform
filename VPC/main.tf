# Create a VPC
resource "aws_vpc" "Panasonic" {
    tags = {
     Name = "Panasonic"
   }
  cidr_block = "10.0.0.0/16"
}

# Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.Panasonic.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Panasonic-Public-Subnet1"
  }
}

# Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.Panasonic.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Panasonic-Private-Subnet1"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Panasonic.id

  tags = {
    Name = "Panasonic-GW"
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
    Name = "Panasonic-Public-RT"
  }
}

# Add tag to the Main Route Table
resource "aws_default_route_table" "private-RT" {
  default_route_table_id = "${aws_vpc.Panasonic.default_route_table_id}"

  tags = {
    Name = "Panasonic-Private-RT"
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