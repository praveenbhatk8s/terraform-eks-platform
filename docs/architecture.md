# Platform Architecture

This architecture represents a production-oriented EKS foundation. Terraform provisions the AWS primitives, EKS provides the Kubernetes control plane, and platform add-ons deliver GitOps, certificates, DNS, monitoring, and backup capabilities.

```mermaid
flowchart TB
  subgraph Delivery["Delivery Control Plane"]
    GitHub["GitHub Actions"]
    Terraform["Terraform"]
  end

  subgraph AWS["AWS"]
    subgraph Network["Networking"]
      VPC["VPC"]
      Public["Public subnets"]
      Private["Private subnets"]
      NAT["NAT Gateway"]
    end

    subgraph Identity["Identity"]
      IAM["IAM"]
      IRSA["IRSA roles"]
    end

    subgraph Kubernetes["EKS Platform"]
      EKS["EKS control plane"]
      MNG["Managed node groups"]
      Karpenter["Karpenter"]
      Addons["Platform add-ons"]
    end

    Backup["Velero backups<br/>S3 target"]
  end

  GitHub --> Terraform
  Terraform --> VPC
  Terraform --> IAM
  Terraform --> EKS
  VPC --> Public
  VPC --> Private
  Public --> NAT
  EKS --> MNG
  EKS --> Karpenter
  IRSA --> Addons
  Addons --> Backup
```

## Traffic and Operations

```mermaid
flowchart LR
  Users["Users"] --> DNS["Route53 / external-dns"]
  DNS --> ALB["AWS Load Balancer"]
  ALB --> Services["Kubernetes Services"]
  Services --> Pods["Application Pods"]

  Argo["Argo CD"] --> Services
  Prom["Prometheus / Grafana"] --> Pods
  Velero["Velero"] --> Backup["S3 backups"]
```

## Design Intent

| Layer | Intent |
| --- | --- |
| VPC | Provide isolated, multi-subnet network foundation |
| EKS | Host workloads on managed Kubernetes |
| Managed node groups | Provide baseline compute capacity |
| Karpenter | Add dynamic right-sized compute |
| IRSA | Avoid static cloud credentials in pods |
| Add-ons | Enable GitOps, DNS, certificates, monitoring, backup |
| CI | Validate infrastructure changes before merge/apply |
