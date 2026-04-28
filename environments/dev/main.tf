provider "aws" {
  region = "eu-central-1"
}

module "vpc" {
  source     = "../../modules/vpc"
  name       = "dev-vpc"
  cidr_block = "10.10.0.0/16"
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = "dev-eks"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}