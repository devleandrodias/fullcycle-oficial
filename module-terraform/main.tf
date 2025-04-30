module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "eks" {
  source                     = "./modules/eks"
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.subnet_ids
  prefix                     = var.prefix
  region                     = var.region
  cluster_name               = var.cluster_name
  cluster_log_retention_days = var.cluster_log_retention_days
  desired_size               = var.desired_size
  max_size                   = var.max_size
  min_size                   = var.min_size
}
