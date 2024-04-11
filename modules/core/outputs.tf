output "load-balancer-ip" {
  value = google_compute_address.service-ip.address
}

output "artifact-registry-id" {
  value = google_artifact_registry_repository.service_repo.id
}