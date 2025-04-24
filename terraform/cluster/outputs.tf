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