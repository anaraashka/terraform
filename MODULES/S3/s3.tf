
locals {
  #bucket_name = "${var.bucket_name}-${local.prefix}"
  region = "${data.aws_region.current.id}"
  suffix = "backend"
}

variable "your_last_name" {}

resource "aws_s3_bucket" "devops-s3" {

  bucket = "${var.your_last_name}-${local.region}-${local.suffix}"
}

resource "aws_s3_bucket_object" "folder1" {
    bucket = aws_s3_bucket.devops-s3.id
    key    = "production/"
}

resource "aws_s3_bucket_object" "folder2" {
    bucket = aws_s3_bucket.devops-s3.id
    key    = "sandbox/"
}

resource "aws_s3_bucket_object" "folder3" {
    bucket = aws_s3_bucket.devops-s3.id
    key    = "QA/"
}