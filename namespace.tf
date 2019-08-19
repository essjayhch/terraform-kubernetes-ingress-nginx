resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace

    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}
