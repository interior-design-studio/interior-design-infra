resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}



module "storage" {
  depends_on          = [azurerm_resource_group.rg]
  source              = "./modules/storage"
  location            = azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  az_storage_account_name = var.az_storage_account_name

}


module "network" {
  depends_on                  = [azurerm_resource_group.rg]
  source                      = "./modules/network"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  # virtual_network_name        = var.virtual_network_name
  # vnet_address_prefix         = var.vnet_address_prefix
  # subnet_name                 = var.subnet_name
  # subnet_address_prefix       = var.subnet_address_prefix
  # network_security_group_name = var.network_security_group_name
  public_ip_address_name      = var.public_ip_address_name
  dns_label                   = var.dns_label

}

module "kubernetes" {
  depends_on          = [azurerm_resource_group.rg]
  source              = "./modules/kubernetes"
  location            = azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name
  aks_name           = var.aks_name
  aks_dns_prefix     = var.aks_dns_prefix
  node_count         = var.node_count
  vm_size            = var.vm_size
  ssh_pub_key_file     = var.ssh_pub_key_file
  ssh_private_key_file = var.ssh_private_key_file
  ssh_user_name        = var.ssh_user_name
  dns_label            = var.dns_label
  public_ip_id         = module.network.public_ip_id
  public_ip_address_name      = var.public_ip_address_name
  # public_ip_fqdn       = module.network.public_ip_fqdn
  load_balancer_resource_group = var.resource_group_name
  kubernetes_version   = var.kubernetes_version

}

# data "azurerm_client_config" "current" {}
