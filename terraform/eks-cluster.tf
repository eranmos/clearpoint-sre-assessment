###############
# EKS Cluster #
###############
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_version = var.kubernetes_version
  cluster_name    = local.eks_cluster_name
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  enable_irsa     = var.cluster_irsa

  worker_groups = [
    {
      name                          = "worker-group-frontend"
      instance_type                 = var.frontend_instance_type
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_eks_worker_mgmt.id]
      kubelet_extra_args            = "--node-labels=role=frontend"
    },
    {
      name                          = "worker-group-backend"
      instance_type                 = var.backend_instance_type
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.all_eks_worker_mgmt.id]
      kubelet_extra_args            = "--node-labels=role=backend"
    }
  ]

  map_users = [
    {
      userarn  = var.eks_userarn
      username =
      groups   = ["system:masters"]
    },
  ]

  tags = {
    Name                         = local.eks_cluster_name
    Owner                        = var.owner
    Environment_Name             = var.environment_name
    Project_Name                 = var.project_name
    resource-owner               = var.asset_owner
    environment-type             = var.environment
    application-asset-insight-id = var.asset_id
  }

}