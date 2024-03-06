module "monitoring_bucket" {
  source = "../S3"
}

module "vpc" {
  source = "../../VPC"
}