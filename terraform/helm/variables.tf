variable "SECRET_KEY" {
  type        = string
  description = "Django secret key used for cryptographic signing"
}

variable "ALLOWED_HOSTS" {
  type        = string
  description = "Comma-separated list of allowed hosts for Django (used in ALLOWED_HOSTS)"
}

# variable "DJANGO_ALLOWED_HOSTS" {
#   type        = string
#   description = "Comma-separated list of allowed hosts for Django (used in ALLOWED_HOSTS)"
# }

variable "POSTGRES_DB" {
  type        = string
  description = "Name of the PostgreSQL database"
}

variable "POSTGRES_USER" {
  type        = string
  description = "Username for the PostgreSQL database"
}

variable "POSTGRES_PASSWORD" {
  type        = string
  sensitive   = true
  description = "Password for the PostgreSQL database user"
}

variable "POSTGRES_HOST" {
  type        = string
  description = "Hostname or service name for the PostgreSQL server"
}

variable "POSTGRES_PORT" {
  type        = string
  description = "Port on which PostgreSQL server is listening"
}

variable "CONTROLLER_SERVICE_TYPE" {
  description = "Service type for the Ingress controller (e.g., LoadBalancer, ClusterIP)"
  type        = string
}

variable "CONTROLLER_REPLICA_COUNT" {
  description = "Number of replicas for the Ingress controller"
  type        = number
}

variable "CONTROLLER_NODE_SELECTOR_OS" {
  description = "Node selector OS value for the Ingress controller"
  type        = string
}

variable "DEFAULT_BACKEND_NODE_SELECTOR_OS" {
  description = "Node selector OS value for the default backend"
  type        = string
}