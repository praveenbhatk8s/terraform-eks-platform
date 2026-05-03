# Terraform EKS Platform

[![Terraform](https://github.com/praveenbhatk8s/terraform-eks-platform/actions/workflows/terraform.yml/badge.svg)](https://github.com/praveenbhatk8s/terraform-eks-platform/actions/workflows/terraform.yml)
[![Security Scan](https://github.com/praveenbhatk8s/terraform-eks-platform/actions/workflows/security-scan.yml/badge.svg)](https://github.com/praveenbhatk8s/terraform-eks-platform/actions/workflows/security-scan.yml)
![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazonaws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)
![Karpenter](https://img.shields.io/badge/Karpenter-Autoscaling-2563EB)

Production-style AWS EKS platform built with Terraform modules, environment composition, GitHub Actions validation, and platform add-ons.

## What This Demonstrates

- Reusable Terraform modules for VPC, EKS, IRSA, and Karpenter
- Environment-based composition for dev, stage, and prod
- Private/public subnet platform networking
- Managed node groups and autoscaling foundation
- Argo CD bootstrap for GitOps operations
- Add-on values for cert-manager, external-dns, monitoring, Velero, and SSO
- CI validation for Terraform formatting, validation, planning, and security scanning

## Architecture

```mermaid
flowchart TB
  GitHub["GitHub Actions<br/>fmt / validate / plan / scan"] --> Terraform["Terraform"]

  subgraph AWS["AWS Account"]
    VPC["VPC<br/>public + private subnets"]
    EKS["Amazon EKS<br/>managed control plane"]
    Nodes["Managed node groups"]
    Karpenter["Karpenter<br/>dynamic compute"]
    IAM["IAM + IRSA"]
    Addons["Platform add-ons<br/>Argo CD, cert-manager, external-dns,<br/>monitoring, Velero"]
  end

  Terraform --> VPC
  Terraform --> EKS
  Terraform --> IAM
  EKS --> Nodes
  EKS --> Karpenter
  IAM --> Addons
  EKS --> Addons
```

Detailed architecture: [docs/architecture.md](docs/architecture.md)

## Repository Layout

```text
.
├── .github/workflows/       # Terraform and security CI
├── addons/                  # Helm values for platform add-ons
├── bootstrap/               # Argo CD bootstrap helpers
├── docs/                    # Architecture, diagrams, runbooks
├── environments/            # dev, stage, prod compositions
└── modules/                 # reusable Terraform modules
```

## Modules

| Module | Purpose |
| --- | --- |
| `modules/vpc` | Network foundation for EKS |
| `modules/eks` | EKS cluster and node group primitives |
| `modules/irsa` | IAM Roles for Service Accounts |
| `modules/karpenter` | Autoscaling foundation |

## Environments

| Environment | Path |
| --- | --- |
| dev | `environments/dev` |
| stage | `environments/stage` |
| prod | `environments/prod` |

## Usage

From an environment directory:

```bash
cd environments/dev
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Use the same workflow for `stage` and `prod`, with environment-specific variables and backend configuration as needed.

## CI/CD

This repo includes GitHub Actions workflows for:

- Terraform formatting and validation
- Terraform planning
- security scanning

Check:

```bash
.github/workflows/terraform.yml
.github/workflows/security-scan.yml
```

## Platform Add-ons

The `addons/` directory contains values for common EKS platform services:

- cert-manager
- external-dns
- monitoring
- SSO
- Velero backup and restore

## Operating Model

```mermaid
sequenceDiagram
  participant Dev as Platform Engineer
  participant GH as GitHub Actions
  participant TF as Terraform
  participant AWS as AWS
  participant EKS as EKS Platform

  Dev->>GH: Open PR with Terraform change
  GH->>TF: fmt, validate, plan, scan
  TF-->>GH: Plan output
  Dev->>GH: Merge approved change
  GH->>TF: Apply from controlled environment
  TF->>AWS: Provision or update platform
  AWS->>EKS: Reconcile cluster and add-ons
```

## Portfolio Notes

This repository is designed to show platform engineering judgement:

- modular infrastructure boundaries
- environment separation
- secure AWS identity patterns
- autoscaling readiness
- add-on lifecycle thinking
- CI gates before infrastructure changes
