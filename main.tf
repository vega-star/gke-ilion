//SETUP
provider "google" {
  project     = var.PROJECT_ID
  region      = var.SELECTED_REGION
}

data "google_service_account" "terraform_service_account" { # The service account must have been created prior to the execution of Terraform, and the permissions needed granted
  account_id = var.TF_SERVICE_ACCOUNT_ID
}

resource "google_project_service" "gcp_services" {
  for_each = toset(var.USED_API_LIST)
  project = var.PROJECT_ID
  service = each.key
}

// CORE
module "core" {
  source = "./modules/core"

  SELECTED_REGION = var.SELECTED_REGION
  PROJECT_ID = var.PROJECT_ID
  TF_SERVICE_ACCOUNT_ID = var.TF_SERVICE_ACCOUNT_ID
  TF_SERVICE_ACCOUNT_EMAIL = data.google_service_account.terraform_service_account.email
  DB_ROOT_USERNAME = var.DB_ROOT_USERNAME
  DB_INSTANCE_TIER = var.DB_INSTANCE_TIER
  DB_PASSWORD = var.DB_PASSWORD
  DB_HIGH_AVAILABILITY = var.DB_HIGH_AVAILABILITY
  VPC_NAME = var.VPC_NAME
  KUBERNETES_NAMESPACE = var.KUBERNETES_NAMESPACE
  KUBERNETES_APPLICATION_ID = var.KUBERNETES_APPLICATION_ID
}