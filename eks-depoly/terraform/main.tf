module "vpc" {
  source = "../modules/vpc"
  region = var.region
  cluster_name = var.cluster_name
}

module "eks" {
  source = "../modules/eks"
  cluster_name = var.cluster_name
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "iam" {
  source = "../modules/iam"
  cluster_name = var.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
}

module "ecr" {
  source = "../modules/ecr"
}

module "rds" {
  source = "../modules/rds"
  vpc_id = module.vpc.vpc_id
  database_subnets = module.vpc.database_subnets
}

module "addons" {
  source = "../modules/addons"
  cluster_name = module.eks.cluster_name
  cluster_endpoint = module.eks.cluster_endpoint
  aws_load_balancer_controller_role_arn = module.iam.aws_load_balancer_controller_role_arn
  cluster_autoscaler_role_arn = module.iam.cluster_autoscaler_role_arn
  external_dns_role_arn = module.iam.external_dns_role_arn
}

module "route53" {
  source = "../modules/route53"
  domain = var.domain
}
