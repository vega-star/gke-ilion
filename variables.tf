// MAIN VARIABLES
variable "PROJECT_ID" {
  type        = string
  description = "The ID of the project on which the infrastructure will be located in GCP."
  default     = "ilion-demo"
}

variable "SELECTED_LOCATION" {
  type        = string
  description = "General location used in some resources. Not necessarily tied to resources in selected region."
  default     = "US"
}

variable "SELECTED_REGION" {
  type        = string
  description = "Main region of the project, on which most resources will be located at."
  default     = "us-central1"
}

variable "TF_SERVICE_ACCOUNT_ID" {
  type        = string
  description = "ID of the service account used by terraform to deploy resources."
  sensitive   = true
}

variable "USED_API_LIST" {
  type        = list(string)
  description = "The list of apis necessary for the project to function. This prevents errors when planning infrastructure in a new, clean project."
  default = [
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "containerregistry.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}

// DATABASE
variable "DB_INSTANCE_TIER" {
  type        = string
  description = "Tier/size of the instance running the database. It defaults to a very small one"
  default     = "db-f1-micro"
}

variable "DB_ROOT_USERNAME" {
  type        = string
  description = "Optional parameter. Defaults to root"
  default     = "root"
}

variable "DB_PASSWORD" {
  type        = string
  description = "Optional parameter. The DB generates a random password stored in .tfstate if not declared"
  sensitive   = true
}

variable "DB_HIGH_AVAILABILITY" {
  type        = bool
  description = "Optional parameter. Defaults to false."
  default     = false
}

// NETWORKING
variable "VPC_NAME" {
  type        = string
  description = "Name of the VPC used by the core module"
  default     = "ilion-vpc-network"
}

// KUBERNETES
variable "KUBERNETES_NODE_MACHINE_TYPE" {
  type        = string
  description = "The machine type/size for each node in the main cluster"
  default     = "e2-small"
}

variable "KUBERNETES_NAMESPACE" {
  type        = string
  description = "Namspace used by the kubernetes cluster configuration"
  default     = "parking-application-tf"
}

variable "KUBERNETES_APPLICATION_ID" {
  type        = string
  description = "Name of the application that can be used to identify the service"
  default     = "parking-application"
}

variable "TF_SOURCE_BUCKET" {
  type        = string
  description = "The name of the bucket on which GCR will store data"
  default     = "tf-source-data"
}

variable "GCR_REPOSITORY_ID" {
  type        = string
  description = "The name/ID of the repository for the service on GKE"
  default     = "ilion-repo"
}