// TERRAFORM TO KUBERNETES / GKE
// DOCUMENTATION: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
// This section modifies our GKE cluster into our desired configuration, then loads our application into it

provider "kubernetes" {
  host  = "https://${google_container_cluster.main_cluster.endpoint}"
  token = data.google_service_account_access_token.kubernetes_access_token.access_token

  cluster_ca_certificate = base64decode(
    google_container_cluster.main_cluster.master_auth[0].cluster_ca_certificate,
  )
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "kubectl" {
  host = google_container_cluster.main_cluster.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.main_cluster.master_auth.0.cluster_ca_certificate)
  token = data.google_service_account_access_token.kubernetes_access_token.access_token
  load_config_file = false
}

resource "kubernetes_namespace" "default" { # Namespace
  metadata {
    name = var.KUBERNETES_NAMESPACE
  }
}

resource "kubernetes_service" "application-service" { # Aplication service including load balancer
  metadata {
    namespace = kubernetes_namespace.default.metadata.0.name
    name      = var.KUBERNETES_APPLICATION_ID
  }

  spec {
    selector = {
      run = var.KUBERNETES_APPLICATION_ID
    }

    session_affinity = "ClientIP"

    port {
      protocol    = "TCP"
      node_port   = 5003
      port        = 80
      target_port = 80
    }

    type             = "LoadBalancer"
    load_balancer_ip = google_compute_address.service-ip.address
  }
}

resource "kubernetes_replication_controller" "application-controller" { # Application controller
    metadata {
        name      = var.KUBERNETES_APPLICATION_ID
        namespace = kubernetes_namespace.default.metadata[0].name

        labels = {
            run = var.KUBERNETES_APPLICATION_ID
        }
    }

    spec {
    selector = {
      test = var.KUBERNETES_APPLICATION_ID
    }
    template {
      metadata {
        labels = {
          test = var.KUBERNETES_APPLICATION_ID
        }
      }

      spec {
        container {
          image = "parking.wsgi:application"
          name  = var.KUBERNETES_APPLICATION_ID

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}