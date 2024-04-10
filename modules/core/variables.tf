// VARIABLES IMPORTED FROM ROOT MODULE

variable "PROJECT_ID" {
  type = string
}

variable "TF_SERVICE_ACCOUNT_ID" {
  type = string
}

variable "SELECTED_REGION" {
  type = string
}

variable "TF_SERVICE_ACCOUNT_EMAIL" {
  type = string
}

variable "DB_HIGH_AVAILABILITY" {
  type = bool
}
variable "DB_INSTANCE_TIER" {
  type = string
}

variable "DB_ROOT_USERNAME" {
  type = string
}

variable "DB_PASSWORD" {
  type = string
  sensitive = true
}

variable "VPC_NAME" {
  type = string
}

variable "KUBERNETES_NAMESPACE" {
  type = string
}

variable "KUBERNETES_APPLICATION_ID" {
  type = string
}