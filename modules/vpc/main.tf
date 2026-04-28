## modules/vpc/main.tf
```hcl
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  tags = { Name = var.name }
}