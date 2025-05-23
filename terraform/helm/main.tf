resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.12.1"
  namespace        = "ingress-nginx"
  create_namespace = true
  force_update     = true

  set {
    name  = "controller.service.type"
    value = var.CONTROLLER_SERVICE_TYPE
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = data.terraform_remote_state.cluster.outputs.public_ip_address
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = data.terraform_remote_state.cluster.outputs.load_balancer_resource_group
  }


  set {
    name  = "controller.replicaCount"
    value = var.CONTROLLER_REPLICA_COUNT
  }

  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = var.CONTROLLER_NODE_SELECTOR_OS
  }

  set {
    name  = "defaultBackend.nodeSelector.kubernetes\\.io/os"
    value = var.DEFAULT_BACKEND_NODE_SELECTOR_OS
  }
  set {
  name  = "controller.service.externalTrafficPolicy"
  value = "Local"
  }
  #   lifecycle {
  #   prevent_destroy = true
  # }

}

resource "helm_release" "postgres" {
  name       = "postgres"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  namespace  = "default"
  version    = "12.2.5"
  depends_on = [helm_release.ingress_nginx]
  set {
    name  = "auth.username"
    value = var.POSTGRES_USER
  }

  set {
    name  = "auth.password"
    value = var.POSTGRES_PASSWORD
  }

  set {
    name  = "auth.database"
    value = var.POSTGRES_DB
  }

  set {
    name  = "primary.service.port"
    value = var.POSTGRES_PORT
  }
}

resource "helm_release" "frontend" {
  name             = "frontend"
  chart            = "${path.module}/frontend"
  namespace        = "default"
  create_namespace = false

  values = [file("${path.module}/frontend/values.yaml")]

  depends_on = [helm_release.ingress_nginx]
}

resource "helm_release" "django_app" {
  name             = "django-app"
  chart            = "${path.module}/django"
  namespace        = "default"
  create_namespace = false

  depends_on = [helm_release.postgres]

  # set {
  #   name  = "env.DJANGO_ALLOWED_HOSTS"
  #   value = join(",", [
  #     "localhost",
  #     "127.0.0.1",
  #     "0.0.0.0",
  #     data.terraform_remote_state.cluster.outputs.public_ip_fqdn
  #   ])
  # }

  values = [file("${path.module}/django/values.yaml")]
}