resource "kubernetes_deployment" "nginx-ingress-controller" {
  metadata {
    name      = var.deployment_name
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name" : "ingress-nginx"
      "app.kubernetes.io/part-of" : "ingress-nginx"
    }
  }

  spec {
    replicas = var.controller_replicas
    selector {
      match_labels = {
        "app.kubernetes.io/name"    = "ingress-nginx"
        "app.kubernetes.io/part-of" = "ingress-nginx"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name"    = "ingress-nginx"
          "app.kubernetes.io/part-of" = "ingress-nginx"
        }

        annotations = {
          "prometheus.io/port"   = "10254"
          "prometheus.io/scrape" = "true"
        }
      }

      spec {
        termination_grace_period_seconds = 300
        service_account_name = kubernetes_service_account.nginx-ingress-serviceaccount.metadata.0.name        

        container {
          name  = "nginx-ingress-controller"
          image = "quay.io/kubernetes-ingress-controller/nginx-ingress-controller:${var.controller_version}"

          args = [
            "/nginx-ingress-controller",
            "--configmap=$(POD_NAMESPACE)/${kubernetes_config_map.nginx-configuration.metadata.0.name}",
            "--tcp-services-configmap=$(POD_NAMESPACE)/${kubernetes_config_map.tcp-services.metadata.0.name}",
            "--udp-services-configmap=$(POD_NAMESPACE)/${kubernetes_config_map.udp-services.metadata.0.name}",
            "--publish-service=$(POD_NAMESPACE)/ingress-nginx",
            "--annotations-prefix=${var.annotations_prefix}"
          ]

          security_context {
            allow_privilege_escalation = "true"

            capabilities {
              drop = [
                "ALL"
              ]

              add = [
                "NET_BIND_SERVICE"
              ]

            }
            run_as_user = 33
          }

          env {
            name = "POD_NAME"
            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          volume_mount {
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            name       = kubernetes_service_account.nginx-ingress-serviceaccount.default_secret_name
            read_only  = true
          }

          port {
            name           = "http"
            container_port = 80
          }

          port {
            name           = "https"
            container_port = 443
          }

          liveness_probe {
            failure_threshold = 3
            http_get {
              path   = "/healthz"
              port   = 10254
              scheme = "HTTP"
            }

            initial_delay_seconds = 10
            period_seconds        = 10
            success_threshold     = 1
            timeout_seconds       = 10
          }

          readiness_probe {
            failure_threshold = 3
            http_get {
              path   = "/healthz"
              port   = 10254
              scheme = "HTTP"
            }
            period_seconds    = 10
            success_threshold = 1
            timeout_seconds   = 10
          }

          resources {
            requests  {
              cpu = local.actual_resource_requests["cpu"]
              memory = local.actual_resource_requests["memory"]
            }

            limits {
              cpu = local.actual_resource_limits["cpu"]
              memory = local.actual_resource_limits["memory"]
            }
          }

          lifecycle {
            pre_stop {
              exec {
                command = ["/wait-shutdown"]
              }
            }
          }
        }
        volume {
          name = kubernetes_service_account.nginx-ingress-serviceaccount.default_secret_name

          secret {
            secret_name = kubernetes_service_account.nginx-ingress-serviceaccount.default_secret_name
          }
        }
      }
    }
  }
}

resource "kubernetes_limit_range" "nginx-ingress" {
  metadata {
    name      = "ingress-nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
    labels = {
      "app.kubernetes.io/name" : "ingress-nginx"
      "app.kubernetes.io/part-of" : "ingress-nginx"
    }
  }

  spec {
    limit {
      type = "Container"
      default = {
        cpu    = "100m"
        memory = "90Mi"
      }
    }
  }
}
