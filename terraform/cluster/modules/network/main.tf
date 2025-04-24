# resource "azurerm_virtual_network" "vnet" {
#   name                = var.virtual_network_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   address_space       = [var.vnet_address_prefix]

# }

# resource "azurerm_subnet" "subnet" {
#   name                 = var.subnet_name
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = [var.subnet_address_prefix]

# }

# resource "azurerm_network_security_group" "nsg" {
#   name                = var.network_security_group_name
#   location            = var.location
#   resource_group_name = var.resource_group_name

# }

resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_address_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  # domain_name_label   = "${var.dns_label}-${random_integer.random_number.result}"
  domain_name_label   = "${var.dns_label}-${random_integer.random_number.result}"

  tags = {
    environment = "dev"
  }
}

resource "random_integer" "random_number" {
  min = 1000
  max = 9999
}
