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

resource "helm_release" "custom_postgres" {
  name       = "custom-postgres"
  chart      = "${path.module}/postgres-custom"
  namespace  = "default"
  values     = [file("${path.module}/postgres-custom/values.yaml")]
}

# resource "helm_release" "postgres" {
#   name       = "postgres"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "postgresql"
#   namespace  = "default"
#   version    = "12.2.5"
#   depends_on = [helm_release.ingress_nginx]
#   set {
#     name  = "auth.username"
#     value = var.POSTGRES_USER
#   }

#   set {
#     name  = "auth.password"
#     value = var.POSTGRES_PASSWORD
#   }

#   set {
#     name  = "auth.database"
#     value = var.POSTGRES_DB
#   }

#   set {
#     name  = "primary.service.port"
#     value = var.POSTGRES_PORT
#   }
# }

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

  depends_on = [helm_release.custom_postgres]

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

resource "helm_release" "dummy" {
  name             = "dummy-service"
  chart            = "${path.module}/dummy"
  namespace        = "default"
  create_namespace = false
}

resource "helm_release" "tls_ingress" {
  name             = "tls-ingress"
  chart            = "${path.module}/tls"
  namespace        = "default"
  create_namespace = false

  depends_on = [
    helm_release.dummy
  ]
}

# resource "helm_release" "monitoring" {
#   name             = "prometheus"
#   namespace        = "default"
#   create_namespace = false

#   repository       = "https://prometheus-community.github.io/helm-charts"
#   chart            = "kube-prometheus-stack"
#   version          = "71.2.0"

#   values = [
#     file("${path.module}/monitoring/values.yaml")
#   ]
# }

resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "18.5.0"
  namespace  = "default"

  values = [
    <<EOF
auth:
  enabled: false
EOF
  ]
}

resource "helm_release" "celery" {
  name       = "celery"
  chart      = "./celery"
  namespace  = "default"
  values     = [file("${path.module}/celery/values.yaml")]
  depends_on = [helm_release.redis]
}