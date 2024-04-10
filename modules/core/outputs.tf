output "load-balancer-ip" {
  value = google_compute_address.service-ip.address
}