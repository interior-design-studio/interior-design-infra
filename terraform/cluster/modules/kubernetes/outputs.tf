output "kube_config" {
  description = "Configuration to connect to Kubernetes"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_name" {
  description = "The name of the created Kubernetes cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_fqdn" {
  description = "FQDN of the Kubernetes API server"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

# output "public_ip_id" {
#   description = "The ID of the public IP"
#   value       = azurerm_public_ip.pip.id
# }

# output "public_ip_fqdn" {
#   description = "The DNS of the public IP"
#   value       = azurerm_public_ip.pip.fqdn
# }
# output "nginx_fqdn" {
#   value = azurerm_public_ip.pip.fqdn
# }

# output "public_ip_address" {
#   value = azurerm_public_ip.pip.ip_address
# }
output "resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}
output "kube_config_detailed" {
  description = "Full kube_config from AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config
  sensitive   = true
}
output "aks_identity_principal_id" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}




