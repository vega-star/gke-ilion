variable "PROJECT_ID" {
  type = string
}
variable "VPC_NAME" {
  type = string
  default = "ilion-vpc"
}

resource "google_compute_network" "ilion-vpc-network" {
  project                 = var.PROJECT_ID
  name                    = var.VPC_NAME
  auto_create_subnetworks = true
  mtu                     = 1460
}