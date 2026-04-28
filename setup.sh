#!/usr/bin/env bash

# terraform-eks-platform bootstrap script
# Usage:
# chmod +x setup.sh
# ./setup.sh

set -euo pipefail

REPO_NAME="terraform-eks-platform"

echo "Creating ${REPO_NAME} production-grade structure..."

mkdir -p "${REPO_NAME}"
cd "${REPO_NAME}"

# Root files
touch README.md

# GitHub Actions
mkdir -p .github/workflows
touch .github/workflows/terraform.yml
touch .github/workflows/security-scan.yml

# Environments
mkdir -p environments/dev
mkdir -p environments/stage
mkdir -p environments/prod

touch environments/dev/main.tf
touch environments/stage/main.tf
touch environments/prod/main.tf

# Modules
mkdir -p modules/vpc
mkdir -p modules/eks
mkdir -p modules/karpenter
mkdir -p modules/irsa
mkdir -p modules/security

touch modules/vpc/main.tf
touch modules/vpc/variables.tf
touch modules/vpc/outputs.tf

touch modules/eks/main.tf
touch modules/eks/variables.tf
touch modules/eks/outputs.tf

touch modules/karpenter/main.tf
touch modules/karpenter/variables.tf

touch modules/irsa/main.tf
touch modules/irsa/variables.tf
touch modules/irsa/outputs.tf

touch modules/security/main.tf
touch modules/security/variables.tf

# Addons
mkdir -p addons/external-dns
mkdir -p addons/cert-manager
mkdir -p addons/monitoring
mkdir -p addons/velero
mkdir -p addons/sso

touch addons/external-dns/values.yaml
touch addons/cert-manager/values.yaml
touch addons/monitoring/values.yaml
touch addons/velero/values.yaml
touch addons/sso/README.md

# Bootstrap
mkdir -p bootstrap
touch bootstrap/argocd-install.sh
chmod +x bootstrap/argocd-install.sh

# Docs
mkdir -p docs
touch docs/architecture.md
touch docs/runbooks.md
touch docs/diagrams.md

echo ""
echo "Done. Created structure:"
echo "${REPO_NAME}/"
echo ""
echo "Next steps:"
echo "cd ${REPO_NAME}"
echo "git init"
echo "code ."
echo "git add ."
echo "git commit -m 'Initial production-grade platform repo'"