variable "PROJECT_ID" {
  type = string
  description = "The ID of the project on which the infrastructure will be located in GCP."
  default = "ilion-demo"
}

variable "SELECTED_REGION" {
  type = string
  description = "Main region of the project, on which most resources will be located at."
  default = "us-central1"
}

variable "TF_SERVICE_ACCOUNT_ID" {
  type = string
  description = "ID of the service account used by terraform to deploy resources."
  default = "tf_sa_id"
  sensitive = true
}