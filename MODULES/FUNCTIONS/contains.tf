# locals {
#     companies = [ "company-${var.environment}-etl-test1", "company-${var.environment}-etl-test2" ]
                
#     prod_bucket = "prod1-ready-rector-base-s3-bucket"

#     bucket_count = contains(local.companies, var.company) ? 2 : 0
# }

# variable "company" {
#     default = "company-prod-etl-test3"
# }

# resource "aws_s3_bucket" "iqies_my_first_resourse" {
#   count = local.bucket_count #2 / 0
#   bucket = "${local.prod_bucket}${count.index}"
#   acl    = "private"
# }

# variable "environment" {
#     default = "prod"
# }