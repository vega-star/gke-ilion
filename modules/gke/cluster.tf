// GKE - Google Kubernetes Engine
// Documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
// This module represents the usage of GKE in the infrastructure, setting up and configuring the clusters

// SECTION 0: VARIABLES AND DATA



# These variables are empty because their data is passed from root.
variable "PROJECT_ID" {}
variable "TF_SERVICE_ACCOUNT" {}
variable "SELECTED_REGION" {}

data "google_service_account_access_token" "kubernetes_access_token" {
  target_service_account = var.TF_SERVICE_ACCOUNT
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
}

// SECTION 1: CLUSTER RESOURCES
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

    service_account = google_service_account.terraform_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [ google_container_cluster.main_cluster ]
}

// SECTION 2: CLUSTER CONFIGURATION
provider "kubernetes" {
  host  = "https://${data.google_container_cluster.main_cluster.endpoint}"
  token = data.google_service_account_access_token.kubernetes_access_token.access_token

  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

