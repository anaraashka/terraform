resource "aws_s3_bucket" "project-s3-bucket" {
 bucket = var.bucket_name
 force_destroy = true 
}

variable "bucket_name" {
  type = string
  default = "anar-bucket-05-11-2022"
}