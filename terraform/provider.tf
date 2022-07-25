#############
# Providers #
#############

provider "aws" {
  region  = var.aws_region
  profile = var.aws_cli_profile
}

terraform {
  required_version = "1.2.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket  = "clearpoint-terraform-provisioning-bucket"
    key     = "clearpoint_eks/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "eran-private"
  }
}