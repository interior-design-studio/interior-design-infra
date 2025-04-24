terraform {
  backend "local" {
    path = "cluster.terraform.tfstate"
  }
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "mate-azure-task-12"
#     storage_account_name = "mystorageaccounttask12"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#     subscription_id      = "63322e75-611d-4ff5-9a33-1f266fff00ee"
#   }
# }
