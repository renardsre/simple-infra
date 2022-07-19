provider "aws" {

  region                  = local.aws_region
  shared_credentials_file = local.aws_credential_file
  profile                 = local.aws_credential_profile
  skip_region_validation  = local.aws_skip_region_validation

}

terraform {

  required_version = ">= 1.1.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 1.4"
    }
  }

}

module "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  name = "monitoring-vpc"
  cidr = "10.0.0.0/24"

  azs             = ["ap-southeast-1a"]
  public_subnets  = ["10.0.0.0/28"]

  tags = {
    Name        = "monitoring-vpc"
    Type        = "monotoring-tools"
    Environment = "production"
  }
  
}

output "network" {
  value = module.vpc
}
