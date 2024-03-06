module "report_bucket" {
  source = "../modules"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../VPC"
  vpc_cidr = "10.0.0.0/16"
  vpc_cidr_b = "10.0.0.0/16"
  tag = "Nemo-VPC"
  pub_subnet_cidr = "10.0.1.0/24"
  pri_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source = "git@github.com:102vosit/terraform-fa21.git//EC2" 
  subnet_id = module.vpc.subnet_pub_id
  ami_id = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
}