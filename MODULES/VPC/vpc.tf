resource "aws_vpc" "ziyotek_devops" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ziyotek_devops.id
}

resource "aws_route_table" "training" {
  vpc_id = aws_vpc.ziyotek_devops.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.devops_subnet_1[0].id
  route_table_id = aws_route_table.training.id
}
