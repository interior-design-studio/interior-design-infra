output "public_ip_address" {
  description = "Публічний IP з модуля network"
  value       = module.network.public_ip_address
}
output "dns_label" {
  value = var.dns_label
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "aks_name" {
  value = var.aks_name
}
output "load_balancer_resource_group" {
  value = module.kubernetes.load_balancer_resource_group
}
output "public_ip_fqdn" {
  value = module.network.public_ip_fqdn
}