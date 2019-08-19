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
