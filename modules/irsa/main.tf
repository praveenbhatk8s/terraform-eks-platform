module "external_dns_irsa" {
  source = "../../modules/irsa"
  name   = "external-dns"
}