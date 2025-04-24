provider "kubernetes" {
  config_path = "C:\\Users\\victo\\.kube\\config"
}

provider "helm" {
  kubernetes {
    config_path = "C:\\Users\\victo\\.kube\\config"
  }
}
