resource kubernetes_service_account "nginx-ingress-serviceaccount" {
  metadata {
    name      = "${var.deployment_name}-serviceaccount"
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}
