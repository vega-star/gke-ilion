terraform {
  required_providers {
    google = {
      source  = "hashicorp/terraform-provider-google"
      version = ">= 5.24.0"
    }
  }

  required_version = "~> 1.7.5"
}