variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}
variable "location" {
  description = "The location for Azure resources"
  type        = string
}
variable "vm_name" {
  default = "designstudio"
}

variable "vm_size" {
  # default = "Standard_B1s"
  default   = "Standard_B2ms"
}

variable "ssh_pub_key_file" {
  description = "Path to SSH public key file"
  type        = string
}
variable "ssh_private_key_file" {
  description = "Path to SSH private key file"
  type        = string
}
variable "ssh_user_name" {
  description = "SSH puser name"
  type        = string
}
variable "dns_label" {}


variable "public_ip_address_name" {
  description = "Name of the public IP address"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}
variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
variable "client_id" {
  description = "Azure Client ID"
  type        = string
}
variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
}
variable "az_storage_account_name" {
  description = "Azur storage account user name"
  type        = string
}

variable "aks_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}
variable "aks_dns_prefix" {
  description = "DNS prefix for the Kubernetes API server"
  type        = string
}
variable "node_count" {
  description = "The number of nodes in the cluster"
  type        = number
}
variable "kubernetes_version" {
  description = "kubernetes version"
  type        = string
}