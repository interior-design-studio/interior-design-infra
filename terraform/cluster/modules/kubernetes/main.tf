resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version

  # Create node resources in a dedicated node RG to avoid IP conflict
  node_resource_group = "${var.resource_group_name}-node"

  linux_profile {
    admin_username = var.ssh_user_name

    ssh_key {
      key_data = file(var.ssh_pub_key_file)
    }
  }

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
  network_plugin    = "azure"
  load_balancer_sku = "standard"

  load_balancer_profile {
    outbound_ip_address_ids = [var.public_ip_id]
  }
}

  tags = {
    environment = "dev"
  }
}

data "azurerm_client_config" "current" {}

# resource "azurerm_role_assignment" "aks_ip_access" {
#   depends_on = [azurerm_kubernetes_cluster.aks]

#   principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
#   role_definition_name = "Network Contributor"
#   scope                = var.public_ip_id
# }

# # Get current subscription info for use in role assignment
# data "azurerm_client_config" "current" {}
