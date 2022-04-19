module "security_group" {
  source = "../MODULES/SECURITY-GROUPS/"

  sg_vpc = module.vpc.vpc_id

  environment = var.environment
}