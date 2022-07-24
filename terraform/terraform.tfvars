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

#############  ECS Related  ##########
ecs_frontend_instance_type  = "t2.micro"
ecs_backend_instance_type   = "t2.micro"
ecs_frontend_ami            = "ami-1924770e"
ecs_backend_ami             = "ami-1924770e"
generated_key_name          = "clearpoint-key-pair"

#############  Route53 Related  ##########
private_hosted_zone_domain = "clearpoint.int"

#############  AWS EKS  #############
kubernetes_version      = "1.19"
cluster_irsa            = true
backend_instance_type   = "t3.medium"
frontend_instance_type  = "t3.medium"
application_namespace   = "applications"

#############  Tags Related  #############
environment_name = "clearpoint-prod"
owner            = "Eran Moshayov"
project_name     = "clearpoint"
asset_owner      = "eran.mosh@gmail.com"
environment      = "Prod"
asset_id         = "205126"
