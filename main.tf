provider "google" {
  project     = var.PROJECT_ID
  region      = var.SELECTED_REGION
}

//[!] Core resources
resource "google_service_account" "terraform_service_account" {
  account_id   = var.TF_SERVICE_ACCOUNT_ID
  display_name = "Terraform Service Account"
}

//[!] MODULES SECTION
# Main infrastructure
module "ilion-main" {
  source = "./modules/ilion-main"
}