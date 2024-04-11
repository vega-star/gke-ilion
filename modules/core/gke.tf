// GKE - Google Kubernetes Engine
// Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
// This module represents most of the usage of GKE in the infrastructure, setting up and configuring the clusters

resource "google_container_cluster" "main_cluster" {
  project = var.PROJECT_ID
  name     = "main-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "main-pool"
  location   = var.SELECTED_REGION
  cluster    = google_container_cluster.main_cluster.name
  node_count = 1

  node_config {
    # preemptible  = true
    machine_type = var.KUBERNETES_NODE_MACHINE_TYPE

    service_account = var.TF_SERVICE_ACCOUNT_EMAIL
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [ google_container_cluster.main_cluster ]
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