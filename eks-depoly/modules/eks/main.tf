variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets
  
  create_cloudwatch_log_group = true
  cluster_enabled_log_types   = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    zufeto_nodes = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  cluster_addons = {
    coredns = { resolve_conflicts = "OVERWRITE" }
    vpc-cni = { resolve_conflicts = "OVERWRITE" }
    kube-proxy = { resolve_conflicts = "OVERWRITE" }
    aws-ebs-csi-driver = { resolve_conflicts = "OVERWRITE" }
  }
}

output "cluster_name" { value = module.eks.cluster_name }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "cluster_certificate_authority_data" { value = module.eks.cluster_certificate_authority_data }
output "oidc_provider_arn" { value = module.eks.oidc_provider_arn }
output "oidc_provider_url" { value = replace(module.eks.cluster_oidc_issuer_url, "https://", "") }
