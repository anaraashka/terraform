module "s3" {
  source = "../MODULES/S3"

  environment        = var.environment
  s3_acl             = "public-read"
  versioning_enabled = true
  create_s3 = false
  your_last_name = var.your_last_name
}