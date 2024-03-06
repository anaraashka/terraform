
resource "aws_default_vpc" "name" {
  tags = {
    "Name" = "Rabbit-VPC"
  }
}

locals {
  # ports =[443, 80, 22, 3306, 3389, 53]
  map = {
    "HTTPS" = {
      port        = 443,
      cidr_blocks = ["10.1.0.0/16"]
    }

    "HTTP" = {
      port        = 80,
      cidr_blocks = ["20.0.1.0/24"]
    }

    "SSH" = {
      port        = 22,
      cidr_blocks = ["10.0.1.0/24"]
    }
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_default_vpc.name.id

  dynamic "ingress" {
    for_each = local.map
    content {
      description = ingress.key
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  #   ingress {
  #     description      = "HTTPS"
  #     from_port        = 443
  #     to_port          = 443
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]

  #   }
  #   ingress {
  #     description      = "HTTP"
  #     from_port        = 80
  #     to_port          = 80
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]

  #   ingress {
  #     description      = "SSH"
  #     from_port        = 22
  #     to_port          = 22
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]
  #   }

  #   ingress {
  #     description      = "RDP"
  #     from_port        = 3389
  #     to_port          = 3389
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]
  #   }

  #   ingress {
  #     description      = "My/SQL"
  #     from_port        = 3306
  #     to_port          = 3306
  #     protocol         = "tcp"
  #     cidr_blocks      = ["0.0.0.0/0"]

  #   }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Rabbit-Security-Group"
  }
}

# locals {
#   user = ["developert", "devops", "anar"]
# }

# resource "aws_iam_user" "name" {
#   count = "${local.user}"
#   name = element(local.user, count.index)
# }

# locals {
#   friut = "apple"
#   car = "Toyota"
#   region = ["us-east-1", "us-east-2", "us-west-1", "us-west-2"]
#   av_zones = ["us-east-1a", "us-east-2a", "us-west-1a", "us-west-2a"]
#   cidrs = ["10.0.0.0/16", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }

# output "region" {
#   value = local.region.3
# }

# output "car_name" {
#   value = local.car
# }

# output "cidrs" {
#   value = local.cidrs
# }

# variable "tags" {
#   type = map(any)
#   default = {
#     "Name" =  "Database-Server"
#     "ENV" = "PROD"
#     "PARTCHING" = "Linux"
#     "Owner" = "Amazon"
#   }
# }

# output "merge_tags" {
#   value = merge("${var.tags}", {DEPARTMENT = "Finance"}, {CreatBy = "Terraform"})
# }

# output "look_up" {
#   value = lookup(var.tags, "DEPARTMENT", "Finance")
# }







# resource "aws_s3_bucket" "name" {
#   bucket = "ziyotek-2022-04-25-${local.account_id}"
#   tags = {
#     "Name" = "My-Bucket-Name"
#   }
# }


# data "aws_caller_identity" "current" {}

# locals {
#   account_id = data.aws_caller_identity.current.account_id 
# }

# output "account_id" {
#   value = local.account_id
# }


variable "user_names" {
  type = list
  default = ["David", "Tom", "Roman"]
}

resource "aws_iam_user" "name1" {
  count = length(var.user_names)
  name = element(var.user_names, count.index)
}

output "users" {
  value = aws_iam_user.name1.*.name
}