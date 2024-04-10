variable "DB_HIGH_AVAILABILITY" {
  type = bool
}
variable "DB_INSTANCE_TIER" {
  type = string
}
variable "SELECTED_REGION" {
  type = string
}

variable "DB_PASSWORD" {
    type = string
    sensitive = true
}