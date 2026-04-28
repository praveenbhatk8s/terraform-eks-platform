# terraform-eks-platform

Production-grade AWS EKS platform built with Terraform.

## Features
- Reusable Terraform modules
- VPC with public/private subnets
- EKS cluster with managed node groups
- Karpenter autoscaling support
- ArgoCD bootstrap for GitOps
- GitHub Actions CI for fmt/validate/plan

## Usage
```bash
cd environments/dev
terraform init
terraform plan
terraform apply

## modules/vpc/main.tf
```hcl
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  tags = { Name = var.name }
}
