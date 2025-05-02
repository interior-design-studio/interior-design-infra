resource "azurerm_public_ip" "pip" {
  name                = var.public_ip_address_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  domain_name_label   = "${var.dns_label}-${random_integer.random_number.result}"
  # domain_name_label   = var.dns_label

  tags = {
    environment = "dev"
  }
}

resource "random_integer" "random_number" {
  min = 1000
  max = 9999
}

