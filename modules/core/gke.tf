// GKE - Google Kubernetes Engine
// Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
// This module represents the usage of GKE in the infrastructure, setting up and configuring the clusters

resource "google_container_cluster" "main_cluster" {
  project = var.PROJECT_ID
  name     = "my-gke-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "main-pool"
  location   = var.SELECTED_REGION
  cluster    = google_container_cluster.main_cluster.name
  node_count = 1

  node_config {
    # preemptible  = true
    machine_type = "e2-medium"

    service_account = var.TF_SERVICE_ACCOUNT_EMAIL
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [ google_container_cluster.main_cluster ]
}
