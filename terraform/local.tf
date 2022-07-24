#############
# LOCALS
#############
locals {

  eks_cluster_name = "${var.asset_id}-eks-${var.project_name}-${var.environment}"
  k8s_service_account_namespace = "default"
  k8s_service_account_name      = "clearpoint-sa"

  common_tags = {
    Owner                         = var.owner
    Environment_Name              = var.environment_name
    Project_Name                  = var.project_name
    Resource_Owner                = var.asset_owner
    Environment_Type              = var.environment
    Application_Asset_Insight_ID  = var.asset_id
  }
}

