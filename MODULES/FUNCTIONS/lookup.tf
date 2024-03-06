#this resource will create a separate ec2 instance in th edefault VPC. It will error is a default VPC doesnt exist. 

# resource "aws_instance" "web" {
#   ami = lookup(var.amis, var.region, "")

#   instance_type = "t2.micro"

# }

# variable "amis" {
#     type = map
#     default = {
#         "us-east-1" = "ami-0ed9277fb7eb570c9", #1
#         "us-west-1" = "ami-03af6a70ccd8cb578", #2
#         "us-east-2" = "ami-002068ed284fb165b", #3
#     }
# }

# variable "region" {
#     default = "us-west-2"
# }