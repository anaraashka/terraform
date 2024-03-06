resource "aws_subnet" "devops_subnet_1" {
  count = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.ziyotek_devops.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = var.zone_1
}

