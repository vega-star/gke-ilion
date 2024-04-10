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

resource "kubernetes_namespace" "master" {
  metadata {
    name = "master"
  }
}

resource "google_compute_address" "service-ip" {
  name   = data.google_compute_network.ilion-vpc-network.name
  region = var.SELECTED_REGION
}

resource "kubernetes_service" "parking-application" {
  metadata {
    namespace = kubernetes_namespace.master.metadata[0].name
    name      = "parking-application"
  }

  spec {
    selector = {
      run = "parking-application"
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

resource "kubernetes_replication_controller" "parking-application-controller" {
    metadata {
        name      = "parking-application"
        namespace = kubernetes_namespace.master.metadata[0].name

        labels = {
            run = "parking-application"
        }
    }

    spec {
    selector = {
      test = "parking-application"
    }
    template {
      metadata {
        labels = {
          test = "parking-application"
        }
      }

      spec {
        container {
          image = "parking.wsgi:application"
          name  = "parking-application"

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

output "load-balancer-ip" {
  value = google_compute_address.service-ip.address
}