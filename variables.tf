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

variable "DB_INSTANCE_TIER" {
  type = string
  description = "Tier/size of the instance running the database. It defaults to a very small one"
  default = "db-f1-micro"
}

variable "DB_PASSWORD" {
  type = string
  description = "Optional parameter. The DB generates a random password stored in .tfstate if not declared"
  sensitive = true
}

variable "DB_HIGH_AVAILABILITY" {
  type = bool
  description = "Optional parameter. Defaults to false."
  default = false
}