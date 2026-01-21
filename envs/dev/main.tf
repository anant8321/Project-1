module "vpc" {
  source = "../../modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  az_list = var.az_list
  public_sub_cidrs = var.public_sub_cidrs
  private_sub_cidrs = var.private_sub_cidrs
}

module "iam" {
  source = "../../modules/iam"

  project_name = "var.project_name"
}

module "alb"{
  source = "../../modules/alb"

  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public_sub_ids = module.vpc.public_subnet_ids
  app_port = var.app_port
}