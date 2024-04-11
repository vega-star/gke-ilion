// Artifact Registry
// We're going to use Artifact Registry to store our container images used on GKE. Artifact Registry is free up tp 0.5GB. Source: https://cloud.google.com/artifact-registry/pricing
// This module does not include Cloud Build.

resource "google_artifact_registry_repository" "service_repo" {
  location      = var.SELECTED_REGION
  repository_id = var.GCR_REPOSITORY_ID
  format        = "DOCKER"
}