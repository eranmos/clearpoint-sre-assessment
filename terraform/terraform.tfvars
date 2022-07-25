#############
# Variables #
#############

aws_cli_profile = "eran-private"

## AWS account data
aws_region      = "us-east-1"

#############  VPC Related  #############
availablity_zone_a            = "us-east-1a"
availablity_zone_b            = "us-east-1b"
private_dns_name              = "clearpoint.internal"
network_address_space         = "10.0.0.0/21"
public_subnet1_address_space  = "10.0.0.0/24"
private_subnet1_address_space = "10.0.2.0/23"
public_subnet2_address_space  = "10.0.1.0/24"
private_subnet2_address_space = "10.0.4.0/23"

#############  Route53 Related  ##########
private_hosted_zone_domain = "clearpoint.int"

#############  AWS EKS  #############
kubernetes_version      = "1.19"
cluster_irsa            = true
backend_instance_type   = "t3.medium"
frontend_instance_type  = "t3.medium"
application_namespace   = "applications"
eks_userarn             = "arn:aws:iam::861864417278:user/terraform-nz"
eks_username            = "terraform-nz"

#############  Tags Related  #############
environment_name = "clearpoint-prod"
owner            = "Eran Moshayov"
project_name     = "clearpoint"
asset_owner      = "eran.mosh@gmail.com"
environment      = "Prod"
asset_id         = "205126"
