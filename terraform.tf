terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.24.0"
    }
  }

  required_version = "1.7.9"
}