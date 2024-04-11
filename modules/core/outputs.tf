output "main_gke_cluster" {
  value = google_container_cluster.main_cluster.name
}

output "artifact-registry-short-path" {
  value = "${var.SELECTED_LOCATION}-docker.pkg.dev"
}

output "artifact-registry-path" {
  value = "${var.SELECTED_LOCATION}-docker.pkg.dev/${var.PROJECT_ID}/${var.GCR_REPOSITORY_ID}"
}