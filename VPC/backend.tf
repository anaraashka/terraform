terraform {
  backend "s3" {
      bucket = "anuuradanar"
      key = "terraform/tfstate.tf"
      region = "us-east-1"
  }
}