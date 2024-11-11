# ingress/outputs.tf

output "api_domain" {
  description = "The domain name of the api"
  value       = var.api_domain
}

output "api_ingress_ip" {
  description = "api ingress ip"
  value       = try(kubernetes_ingress_v1.nginx.status[0].load_balancer[0].ingress[0].ip, "IP not yet assigned")
}

output "app_domain" {
  description = "The domain name of the app"
  value       = var.app_domain
}

output "app_load_balancer_ip" {
  description = "The IP address of the load balancer."
  value       = google_compute_global_forwarding_rule.static_site_forwarding_rule.ip_address
}

output "app_https_load_balancer_ip" {
  description = "The IP address of the load balancer."
  value       = google_compute_global_forwarding_rule.static_site_https_forwarding_rule.ip_address
}