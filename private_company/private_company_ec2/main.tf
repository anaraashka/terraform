resource "aws_vpc" "vpc-ec2" {
  cidr_block = var.VPC-CIDR
  tags = {
    Name = var.VPC-NAME
  }
}

resource "aws_subnet" "public_subnet" {
  count             = 3
  cidr_block        = cidrsubnet(var.VPC-CIDR, 8, count.index + 1)
  availability_zone = var.availability_zones[count.index]
  vpc_id            = aws_vpc.vpc-ec2.id
  map_public_ip_on_launch = true 
  tags = {
    Name = "Public-Subnet${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 3
  cidr_block        = cidrsubnet(var.VPC-CIDR, 8, count.index + 4)
  availability_zone = var.availability_zones[count.index]
  vpc_id            = aws_vpc.vpc-ec2.id
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet${count.index + 1}"
  }
}

resource "aws_internet_gateway" "ec2_internet_gw" {
  vpc_id = aws_vpc.vpc-ec2.id
  tags = {
    "Name" = "${var.VPC-NAME}-internet-gw"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.vpc-ec2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_internet_gw.id
  }
  tags = {
    "Name" = "PUBLIC_ROUTE_TABLE"
  }
}


resource "aws_eip" "Net-Gateway-EIP" {
  count = 3
  depends_on = [
    aws_internet_gateway.ec2_internet_gw
  ]
  vpc = true
  tags = {
    "Name" = "${var.VPC-NAME}-NAT-Gateway EIP"
  }
}

resource "aws_nat_gateway" "NAT_GATEWAY" {
  count = 3
  depends_on = [
    aws_eip.Net-Gateway-EIP
  ]
  allocation_id = element(aws_eip.Net-Gateway-EIP.*.id, count.index)
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  tags = {
    Name = "${var.VPC-NAME}-NAT_GATEWAY"
  } 
}

resource "aws_route_table" "private-RT" {
  count  = 3
  depends_on = [
    aws_vpc.vpc-ec2,
    aws_nat_gateway.NAT_GATEWAY
  ]
  vpc_id = aws_vpc.vpc-ec2.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.NAT_GATEWAY.*.id, count.index)
  }
  tags = {
    "Name" = "PRIVATE-ROUTE-TABLE${count.index + 1}"
  }
}

resource "aws_route_table_association" "public-RT1" {
  count          = 3
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public-RT.id
}

resource "aws_route_table_association" "private-RT1" {
  count          = 3
  depends_on = [
    aws_subnet.private_subnet,
    aws_route_table.private-RT,
  ]
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private-RT.*.id, count.index)
}
#CREATE SECURITY GROUP FOR APP-DEV-WEB-SERVERS
resource "aws_security_group" "allow_tls" {
  name        = "${var.VPC-NAME}-Security-Group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc-ec2.id

  #HTTP Access
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH Access
  ingress {
    description = "from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS Access
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "${var.VPC-NAME}_allow_tls"
  }
}

# CREATE SECURIY GROUP FOR LOAD BALANCER
resource "aws_security_group" "elb_sg" {
  name        = "${var.VPC-NAME}-Load-Balancer-Security-Group"
  description = "LOAD BALANCER SECIRITY GROUP"
  vpc_id      = aws_vpc.vpc-ec2.id
ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 
 tags = {
    Name = "${var.VPC-NAME}-Load-Balancer-Security-Group"
  } 
}

# # Create EC2 instance
resource "aws_launch_configuration" "appserver-launch-config" {
  name_prefix = "appserver-launch-config"
  depends_on = [
    aws_security_group.allow_tls,
    aws_nat_gateway.NAT_GATEWAY,
    aws_route_table_association.private-RT1
  ]
  image_id                    = data.aws_ami.amznlx2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "ec2-key"
  user_data                   = file("APP_SERVER.sh")
  security_groups             = [aws_security_group.allow_tls.id]
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "devserver-launch-config" {
   depends_on = [
    aws_security_group.allow_tls,
    aws_nat_gateway.NAT_GATEWAY,
    aws_route_table_association.private-RT1
  ] 
  image_id                     = data.aws_ami.amznlx2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "ec2-key"
  user_data                   = file("DEV_SERVER.sh")
  security_groups             = [aws_security_group.allow_tls.id]
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_launch_configuration" "webserver-launch-config" {
  depends_on = [
    aws_security_group.allow_tls,
    aws_nat_gateway.NAT_GATEWAY,
    aws_route_table_association.private-RT1
  ]
  image_id                    = data.aws_ami.amznlx2.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "ec2-key"
  user_data                   = file("WEB_SERVER.sh")
  security_groups             = [aws_security_group.allow_tls.id]
  lifecycle {
    create_before_destroy = true
  }
}

# CREATE AUTO SCALING GROUP
resource "aws_autoscaling_group" "ec2_scaling_rule1" {
  count = 1
  name       = "APP_SERVER"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = true
  depends_on         = [aws_lb.ALB-tf1]
  target_group_arns  =  [aws_lb_target_group.TG-tf1.arn]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.appserver-launch-config.name
  vpc_zone_identifier = [element(aws_subnet.private_subnet.*.id, 0)]
  
 tag {
       key                 = "Name"
       value               = "APP_SERVER"
       propagate_at_launch = true
    }
}
resource "aws_autoscaling_group" "ec2_scaling_rule2" {
  count = 1
  name       = "DEV_SERVER"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = true
  depends_on         = [aws_lb.ALB-tf2]
  target_group_arns  =  [aws_lb_target_group.TG-tf2.arn]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.devserver-launch-config.name
  vpc_zone_identifier = [element(aws_subnet.private_subnet.*.id, 1)]
  
 tag {
       key                 = "Name"
       value               = "DEV_SERVER"
       propagate_at_launch = true
    }
}
resource "aws_autoscaling_group" "ec2_scaling_rule3" {
  count = 1
  name       = "WEB-SERVER"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = true
  depends_on         = [aws_lb.ALB-tf3]
  target_group_arns  =  [aws_lb_target_group.TG-tf3.arn]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier = [element(aws_subnet.private_subnet.*.id, 2)]
  
 tag {
       key                 = "Name"
       value               = "WEB-SERVER"
       propagate_at_launch = true
    }
}

#CREATE TARGET GROUP
resource "aws_lb_target_group" "TG-tf1" {
  name     = "Company-TargetGroup-1"
  depends_on = [aws_vpc.vpc-ec2]
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ec2.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}
resource "aws_lb_target_group" "TG-tf2" {
  name     = "Company-TargetGroup-2"
  depends_on = [aws_vpc.vpc-ec2]
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ec2.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}
resource "aws_lb_target_group" "TG-tf3" {
  name     = "Company-TargetGroup-3"
  depends_on = [aws_vpc.vpc-ec2]
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ec2.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60 
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

# CREATE ALB
resource "aws_lb" "ALB-tf1" {
  count = 1
  name              = "APP-SERVER"
  internal           = false
  load_balancer_type = "application"
  security_groups  = [aws_security_group.elb_sg.id]
  subnets          = [element(aws_subnet.public_subnet.*.id, 0), element(aws_subnet.public_subnet.*.id, 1), element(aws_subnet.public_subnet.*.id, 2)]
  tags = {
        Name  = "app_server"
       }
}
resource "aws_lb" "ALB-tf2" {
  count = 1
  name              = "DEV-SERVER"
  internal           = false
  load_balancer_type = "application"
  security_groups  = [aws_security_group.elb_sg.id]
  subnets          = [element(aws_subnet.public_subnet.*.id, 0), element(aws_subnet.public_subnet.*.id, 1), element(aws_subnet.public_subnet.*.id, 2)]
  tags = {
        Name  = "dev_server"
       }
}
resource "aws_lb" "ALB-tf3" {
  count = 1
  name              = "WEB-SERVER"
  internal           = false
  load_balancer_type = "application"
  security_groups  = [aws_security_group.elb_sg.id]
  subnets          = [element(aws_subnet.public_subnet.*.id, 0), element(aws_subnet.public_subnet.*.id, 1), element(aws_subnet.public_subnet.*.id, 2)]
  tags = {
        Name  = "web_server"
       }
}
# CREATE ALB LISTENER
resource "aws_lb_listener" "front_end1" {
  count = 1
  load_balancer_arn = element(aws_lb.ALB-tf1.*.arn, 0)
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf1.arn
  }
}
resource "aws_lb_listener" "front_end2" {
  count = 1
  load_balancer_arn = element(aws_lb.ALB-tf2.*.arn, 0)
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf2.arn
  }
}
resource "aws_lb_listener" "front_end3" {
  count = 1
  load_balancer_arn = element(aws_lb.ALB-tf3.*.arn, 0)
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG-tf3.arn
  }
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



output "APP_SERVER" {
  value = aws_lb.ALB-tf1.*.dns_name
}
output "DEV_SERVER" {
  value = aws_lb.ALB-tf2.*.dns_name
}
output "WEB_SERVER" {
  value = aws_lb.ALB-tf3.*.dns_name
}