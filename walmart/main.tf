resource "aws_vpc" "vpc_anar" {
  cidr_block                       = "10.50.0.0/16"
  tags                             = {
        "Name" = "vpc_anar"
    }
}
resource "aws_subnet" "public_subnet_anar" {
  cidr_block                                     = "10.50.2.0/24"
  tags                                           = {
        "Name" = "public_subnet_anar"
    }
    vpc_id                                         = "vpc-0976b055f2803e1f3"
}
resource "aws_subnet" "private_subnet_anar" {
  cidr_block                                     = "10.50.1.0/24"
  tags                                           = {
        "Name" = "private_subnet_anar"
    }
    vpc_id                                         = "vpc-0976b055f2803e1f3"
}
resource "aws_internet_gateway" "internet_gateway_anar" {
  tags     = {
        "Name" = "internet_gateway_anar"
    }
  vpc_id   = "vpc-0976b055f2803e1f3"
}
resource "aws_route_table" "route_tb_public_anar" {
  tags             = {
        "Name" = "route_tb_public_anar"
    }
  vpc_id           = "vpc-0976b055f2803e1f3"
}
resource "aws_route_table" "route_tb_private_anar" {
  tags             = {
        "Name" = "route_tb_private_anar"
    }
  vpc_id           = "vpc-0976b055f2803e1f3"
}