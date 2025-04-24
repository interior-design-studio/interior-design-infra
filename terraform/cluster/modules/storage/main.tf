resource "azurerm_storage_account" "storage" {
  name                     = var.az_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "container" {
  name                  = "task-artifacts"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"

}
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "blob"
}

# resource "azurerm_managed_disk" "bd_disk" {
#   name                 = "bd-disk"
#   location             = var.location
#   resource_group_name  = var.resource_group_name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = var.bd_disk_size
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "bd_disk_attach" {
#   managed_disk_id    = azurerm_managed_disk.bd_disk.id
#   virtual_machine_id = var.bd_vm_id
#   lun               = 0
#   caching           = "ReadWrite"
# }