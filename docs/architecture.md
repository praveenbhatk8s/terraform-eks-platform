# Platform Architecture

Users -> Route53 -> ALB -> EKS -> Services
                      -> ArgoCD
                      -> Prometheus/Grafana
                      -> Velero(S3)