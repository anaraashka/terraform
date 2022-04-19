resource "aws_vpc" "ec2_vpc" {
  cidr_block           = var.cidrs.0
  enable_dns_hostnames = true
  tags = {
    Name = "Panda"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block        = var.cidrs.1
  availability_zone = var.av_zones.0
  vpc_id            = aws_vpc.ec2_vpc.id
  tags = {
    "Name" = "Panda-Public-Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  cidr_block        = var.cidrs.2
  availability_zone = var.av_zones.1
  vpc_id            = aws_vpc.ec2_vpc.id
  tags = {
    "Name" = "Panda-Public-Subnet"
  }
}

resource "aws_internet_gateway" "ec2_internet_gw" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = {
    "Name" = "Panda-Internet-Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.ec2_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_internet_gw.id
  }
  tags = {
    "Name" = "Public Route Table"
  }
}

resource "aws_default_route_table" "private_rt" {
  default_route_table_id = aws_vpc.ec2_vpc.default_route_table_id
  tags = {
    "Name" = "Panda-Private-RT"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_default_route_table.private_rt.id
}

resource "aws_security_group" "allow_tls" {
  name        = "Panda-Security-Group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.ec2_vpc.id



  # HTTP Access
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH Access
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Panda_allow_tls"
  }
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amznlx2.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "ec2-key"
  user_data = file("user_data.sh")
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [ aws_security_group.allow_tls.id ]
  tags = {
    "Name" = "Panda-Web-Server"
  }
}
output "public_ip" {
  value = aws_instance.web_server.public_ip
}

data "aws_ami" "amznlx2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "aws_ami" {
  value = data.aws_ami.amznlx2.id
}