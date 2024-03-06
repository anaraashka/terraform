output "vpc_id" {
    value = aws_vpc.ziyotek_devops.id
}

output "subnet_1_id" {
    value = aws_subnet.devops_subnet_1[0].id
}
