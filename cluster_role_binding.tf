resource "kubernetes_cluster_role_binding" "nginx-ingress-clusterrole-nisa-binding" {
  metadata {
    name = "nginx-ingress-clusterrole-nisa-binding"
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx"
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.nginx-ingress-clusterrole.metadata.0.name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.nginx-ingress-serviceaccount.metadata.0.name
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }
}
