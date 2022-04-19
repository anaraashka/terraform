module "vpc" {
  source = "../MODULES/VPC"

  vpc_cidr      = "10.10.0.0/16"

}