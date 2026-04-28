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
