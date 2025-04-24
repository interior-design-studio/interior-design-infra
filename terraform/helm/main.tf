resource "helm_release" "postgresql" {
  # depends_on = [module.kubernetes]
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.5.6"
  namespace  = "default"

  values = [yamlencode({
    auth = {
      username = "myuser"
      password = "mypassword"
      database = "mydb"
    }

  })]

  # set {
  #   name  = "auth.postgresPassword"
  #   value = "mypassword"
  # }

  # set {
  #   name  = "primary.persistence.enabled"
  #   value = "false"
  # }
}

resource "helm_release" "ingress_nginx" {
  # depends_on = [module.kubernetes]
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.10.0"
  namespace  = "ingress-nginx"
  create_namespace = true

  # depends_on = [azurerm_public_ip.pip]

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = data.terraform_remote_state.cluster.outputs.public_ip_address
  }

  set {
  name  = "controller.service.annotations.service.beta.kubernetes.io/azure-dns-label-name"
  value = data.terraform_remote_state.cluster.outputs.dns_label
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = data.terraform_remote_state.cluster.outputs.resource_group_name
  }

}

# resource "helm_release" "django" {
#   depends_on = [module.kubernetes.azurerm_kubernetes_cluster.aks]
#   name       = "nginx"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "nginx"
#   version    = "15.0.2"
#   namespace  = "default"
# }
# depends_on = [azurerm_public_ip.pip]

# set {
#   name  = "controller.service.loadBalancerIP"
#   value = module.kubernetes.public_ip_address
# }
  # set {
  #   name  = "image.repository"
  #   value = "interior-design-studio/mydjangoapp"
  # }

  # set {
  #   name  = "image.tag"
  #   value = "latest"
  # }

  # set {
  #   name  = "env[0].name"
  #   value = "DATABASE_HOST"
  # }

  # set {
  #   name  = "env[0].value"
  #   value = "postgresql.default.svc.cluster.local"
  # }