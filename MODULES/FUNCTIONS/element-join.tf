# locals {
#     bucket_names = [ "${local.company}", "${local.department}", "${local.instructor}" ]
                
#     company = "ziyotek"
#     department = "cloud"
#     instructor = "katherine"
# }

# resource "aws_s3_bucket" "iqies_my_second_resourse" {

#   bucket = element(local.bucket_names, 11)
#   acl    = "private"
# }


# resource "aws_s3_bucket" "iqies_my_first_resourse" {

#   bucket = join("-", local.bucket_names)
#   acl    = "private"
# }

# variable "environment" {
#     default = "dev"
# }