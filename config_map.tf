resource "kubernetes_config_map" "nginx-configuration" {
  metadata {
    name      = "${var.deployment_name}-configuration"
    namespace = "${kubernetes_namespace.namespace.metadata.0.name}"
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}

resource "kubernetes_config_map" "tcp-services" {
  metadata {
    name      = "${var.deployment_name}-tcp-services"
    namespace = "${kubernetes_namespace.namespace.metadata.0.name}"
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}

resource "kubernetes_config_map" "udp-services" {
  metadata {
    name      = "${var.deployment_name}-udp-services"
    namespace = "${kubernetes_namespace.namespace.metadata.0.name}"
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}
