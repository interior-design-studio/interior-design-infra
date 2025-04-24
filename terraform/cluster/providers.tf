# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "4.23.0"
#     }
#     # helm = {
#     #   source  = "hashicorp/helm"
#     #   version = "~> 2.0"
#     # }
#     # kubernetes = {
#     #   source  = "hashicorp/kubernetes"
#     #   version = "~> 2.0"
#     # }
#   }
#   required_version = ">= 1.2.0"
# }

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

# data "azurerm_kubernetes_cluster" "aks" {
#   name                = module.kubernetes.aks_name
#   resource_group_name = module.kubernetes.resource_group_name
# }

# data "azurerm_kubernetes_cluster_credentials" "aks" {
#   name                = data.azurerm_kubernetes_cluster.aks.name
#   resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
# }

# provider "kubernetes" {
#   host                   = module.kubernetes.kube_config_detailed[0].host
#   client_certificate     = base64decode(module.kubernetes.kube_config_detailed[0].client_certificate)
#   client_key             = base64decode(module.kubernetes.kube_config_detailed[0].client_key)
#   cluster_ca_certificate = base64decode(module.kubernetes.kube_config_detailed[0].cluster_ca_certificate)
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.kubernetes.kube_config_detailed[0].host
#     client_certificate     = base64decode(module.kubernetes.kube_config_detailed[0].client_certificate)
#     client_key             = base64decode(module.kubernetes.kube_config_detailed[0].client_key)
#     cluster_ca_certificate = base64decode(module.kubernetes.kube_config_detailed[0].cluster_ca_certificate)
#   }
# }
