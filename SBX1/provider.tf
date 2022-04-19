provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Name        = "ziyotek-jenkins-class-worker"
      Environment = var.environment
    }
  }

}

