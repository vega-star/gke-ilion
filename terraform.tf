terraform {
  backend "gcs" {
    bucket  = "tf-source-data"
    prefix  = "terraform/state"
  }

  # required_version = "1.7.5" # Github actions have issues with this field, as it has a specific version of terraform running, so for now it stays commented
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.24.0"
    }
  }
}