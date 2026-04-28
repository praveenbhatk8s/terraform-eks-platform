#!/usr/bin/env bash

# terraform-eks-platform repository bootstrap script
# Usage:
# chmod +x setup.sh
# ./setup.sh

set -e

echo "Creating terraform-eks-platform structure..."

mkdir -p terraform-eks-platform
cd terraform-eks-platform

# folders
mkdir -p .github/workflows
mkdir -p environments/dev
mkdir -p environments/prod
mkdir -p modules/vpc
mkdir -p modules/eks
mkdir -p modules/karpenter
mkdir -p bootstrap

# files
touch README.md
touch .github/workflows/terraform.yml

touch environments/dev/main.tf
touch environments/prod/main.tf

touch modules/vpc/main.tf
touch modules/vpc/variables.tf
touch modules/vpc/outputs.tf

touch modules/eks/main.tf
touch modules/eks/variables.tf
touch modules/eks/outputs.tf

touch modules/karpenter/main.tf

touch bootstrap/argocd-install.sh

chmod +x bootstrap/argocd-install.sh

echo "Done."
echo ""
echo "Repository created:"
echo "terraform-eks-platform/"
echo ""
echo "Next steps:"
echo "cd terraform-eks-platform"
echo "git init"
echo "code ."