variable "controller_version" {
  description = "Version of NGINX Controller to run"
  default     = "0.25.0"
}

variable "controller_replicas" {
  description = "Number of NGINX Controller pods to run"
  default     = 1
}

variable "namespace" {
  description = "Name of Namespace to run nginx controller in"
  default     = "ingress-nginx"
}

variable "cloud_provider" {
  description = "Name of the Provider that you are running K8s on (*generic|node_port)"
  default     = "generic"
}

variable "deployment_name" {
  description  = "pod name"
  default = "nginx-ingress-controller"
}

variable "annotations_prefix" {
  description  = "Set the prefix reguired for annotations for this deployment of nginx"
  default = "nginx.ingress.kubernetes.io"
}

variable "resource_requests" {
  type = map

  description = <<EOF
Resource Requests
ref http://kubernetes.io/docs/user-guide/compute-resources/
resource_requests = {
  memory = "256Mi"
  cpu = "100m"
}
EOF
  default = {}
}

variable "resource_limits" {
  type = map

  description = <<EOF
Resource Requests
ref http://kubernetes.io/docs/user-guide/compute-resources/
resource_limits = {
  memory = "256Mi"
  cpu = "100m"
}
EOF
  default = {}
}
