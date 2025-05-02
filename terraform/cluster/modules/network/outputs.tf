# output "subnet_id" {
#   description = "The ID of the subnet"
#   value       = azurerm_subnet.subnet.id
# }

output "public_ip_id" {
  description = "The ID of the public IP"
  value       = azurerm_public_ip.pip.id
}

output "public_ip_fqdn" {
  description = "The DNS of the public IP"
  value       = azurerm_public_ip.pip.fqdn
}
output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}
