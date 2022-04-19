#Creating study-ss vpc
resource "aws_vpc" "study-ss" {
  cidr_block = var.CIDR.0
  tags = {
    "Name" = "${var.Tag}-VPC"
  }
}
#Create subnets
resource "aws_subnet" "public_subnet_one" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.1
  tags = {
    "Name" = "${var.Tag}-Public-Subnet-One"
  }
}
#Create subnets
resource "aws_subnet" "public_subnet_two" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.2
  tags = {
    "Name" = "${var.Tag}-Public-Subnet-Two"
  }
}
#Create subnets
resource "aws_subnet" "public_subnet_three" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.3
  tags = {
    "Name" = "${var.Tag}-Public-Subnet-Three"
  }
}
#Create subnets
resource "aws_subnet" "public_subnet_four" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.4
  tags = {
    "Name" = "${var.Tag}-Public-Subnet-Four"
  }
}
#Create subnets
resource "aws_subnet" "private_subnet_one" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.5
  tags = {
    "Name" = "${var.Tag}-Private-Subnet-One"
  }
}
#Create subnets
resource "aws_subnet" "private_subnet_two" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.6
  tags = {
    "Name" = "${var.Tag}-Private-Subnet-Two"
  }
}
#Create subnets
resource "aws_subnet" "private_subnet_three" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.7
  tags = {
    "Name" = "${var.Tag}-Private-Subnet-Three"
  }
}
#Create subnets
resource "aws_subnet" "private_subnet_four" {
  vpc_id     = aws_vpc.study-ss.id
  cidr_block = var.CIDR.8
  tags = {
    "Name" = "${var.Tag}-Private-Subnet-Four"
  }
}
