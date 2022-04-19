output "VPC-ID" {
  value = aws_vpc.Panasonic
}
output "VPC-CIDR" {
  value = aws_vpc.Panasonic.cidr_block
}
output "public_subnet_cidr" {
  value = aws_subnet.public_subnet.cidr_block
}
output "private_subnet_cidr" {
  value = aws_subnet.private_subnet.cidr_block
}