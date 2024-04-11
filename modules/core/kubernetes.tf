// TERRAFORM TO KUBERNETES / GKE
// DOCUMENTATION: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
// This section modifies our GKE cluster into our desired configuration, then loads our application into it. Currently not needed

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