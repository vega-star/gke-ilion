data "google_service_account_access_token" "kubernetes_access_token" {
  target_service_account = var.TF_SERVICE_ACCOUNT_EMAIL
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
}

data "google_compute_network" "ilion-vpc-network" {
  name = "ilion-vpc-network"
}