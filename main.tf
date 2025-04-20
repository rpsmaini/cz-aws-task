# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }

#   required_version = ">= 1.3.0"
# }

# provider "aws" {
#   region = var.aws_region
# }

# module "vpc" {
#   source = "./vpc"
# }

# module "sg" {
#   source     = "./sg"
#   depends_on = [module.vpc]
#   vpc-id     = module.vpc.vpc_id
# }

# module "asg" {
#  source                 = "./asg"
#  depends_on             = [module.sg, module.vpc]
#  vpc_security_group_ids = [module.sg.node-app-sg]
#  vpc_private_subnets = [module.vpc.sbnt-pr-1-id.id, module.vpc.sbnt-pr-2-id.id]
# }

# module "alb" {
#   source = "./alb"
#   depends_on = [ module.sg, module.vpc, module.asg ]
#   vpc-id = module.vpc.vpc_id
#   vpc_public_subnets =  [module.vpc.sbnt-pb-1-id.id, module.vpc.sbnt-pb-2-id.id]
#   asg-id = module.asg.asg_id
# }

# module "ecr" {
#   source = "./ecr"
# }