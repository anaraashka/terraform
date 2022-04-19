output "vpc_infor" {
    description = "This output is for VPC"
  value = [
      aws_vpc.study-ss.id,
      aws_vpc.study-ss.cidr_block,
      aws_vpc.study-ss.arn
  ]
}
output "public_subnet_info" {
    description = "This output is for SUBNET"
  value = [
      aws_subnet.public_subnet_one.id,
      aws_subnet.public_subnet_one.cidr_block,
      aws_subnet.public_subnet_one.arn
  ]
}