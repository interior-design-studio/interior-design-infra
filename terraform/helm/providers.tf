terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.1"
    }
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\victo\\.kube\\config"
}

provider "helm" {
  kubernetes {
    config_path = "C:\\Users\\victo\\.kube\\config"
  }
}
