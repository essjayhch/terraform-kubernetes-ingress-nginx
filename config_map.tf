resource "kubernetes_config_map" "nginx-configuration" {
  metadata {
    name      = "nginx-configuration"
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_config_map" "tcp-services" {
  metadata {
    name      = "tcp-services"
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "kubernetes_config_map" "udp-services" {
  metadata {
    name      = "udp-services"
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }

  lifecycle {
    ignore_changes = all
  }
}
