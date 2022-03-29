# I am creating dev user
resource "aws_iam_user" "dev-user" {
  name = "Dev-John"
}
resource "aws_iam_user" "Tom" {
  name = "Tom"
}
resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}
resource "aws_iam_group_membership" "developers-attachment" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.dev-user.name,
    aws_iam_user.Tom.name,
  ]

  group = aws_iam_group.developers.name
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
 

  groups     = [aws_iam_group.developers.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# # Create a VPC
# resource "aws_vpc" "name" {
#   cidr_block = "10.50.0.0/16"
# }

## Deafult VPC
# resource "aws_default_vpc" "default-vpc" {
#   tags = {
#     Name = "Default VPC"
#   }
# }

## Default Subnet
# resource "aws_default_subnet" "default_az1" {
#   availability_zone = "us-east-1a"
# }

# ## Security Groups
# resource "aws_security_group" "allow-traffic" {
#   name        = "allow-traffic"
#   description = "Allow inbound traffic"
#   vpc_id      = aws_default_vpc.default-vpc.id
#   ingress {
#     description = "HTTP"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#   }
#   ingress {
#     description = "HTTP8000"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = 8000
#     to_port     = 8000
#     protocol    = "tcp"
#   }

#   ingress {
#     description = "HTTP8000"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#   }

#   ingress {
#     description = "SSH"
#     cidr_blocks = ["0.0.0.0/0"]
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "Allow Inbound Traffic"
#   }
# }

# ## EC2 Instance
# resource "aws_instance" "web-server" {
#   ami                         = "ami-0ed9277fb7eb570c9"
#   instance_type               = "t2.micro"
#   key_name                    = "my-key"
#   security_groups             = [aws_security_group.allow-traffic.id]
#   subnet_id                   = aws_default_subnet.default_az1.id
#   associate_public_ip_address = true

#   tags = {
#     Name = "web-server"
#   }
# }


# output "dns_name" {
#   value       = aws_instance.web-server.public_dns
#   description = " EC2 instance public address "
# }
