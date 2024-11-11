# dns/dns.tf

resource "google_dns_record_set" "api_dns" {
  name         = "${data.terraform_remote_state.ingress.outputs.api_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = "winball-io-zone"

  rrdatas = [
    data.terraform_remote_state.ingress.outputs.api_ingress_ip
  ]
}

resource "google_dns_record_set" "app_https_dns" {
  name         = "${data.terraform_remote_state.ingress.outputs.app_domain}."
  type         = "A"
  ttl          = 300
  managed_zone = "winball-io-zone"

  rrdatas = [
    data.terraform_remote_state.ingress.outputs.app_https_load_balancer_ip
  ]
}
