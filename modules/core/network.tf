resource "google_compute_network" "ilion-vpc-network" {
  project                 = var.PROJECT_ID
  name                    = var.VPC_NAME
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_address" "service-ip" {
  name   = google_compute_network.ilion-vpc-network.name
  region = var.SELECTED_REGION

  depends_on = [ google_compute_network.ilion-vpc-network ]
}