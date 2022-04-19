# module "rds" {
#   source = "../MODULES/RDS"

#   environment = var.environment

#   subnet_ids = [module.vpc.subnet_1_id, module.vpc.subnet_2_id]
#   vpc_security_group = [module.security_group.vpc_sg]
# }