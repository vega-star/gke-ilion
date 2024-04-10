resource "google_compute_global_address" "db-private-ip-address" {
  name          = "db-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.ilion-vpc-network.id

  depends_on = [ google_compute_network.ilion-vpc-network ]
}

resource "google_sql_database_instance" "db_instance" {
  name = "ilion-db-instance"
  region = var.SELECTED_REGION
  database_version = "POSTGRES_14"
  settings {
    tier = var.DB_INSTANCE_TIER
  }

  deletion_protection  = "true"
}

resource "google_sql_database" "database" {
  name     = "ilion-database"
  instance = google_sql_database_instance.db_instance.name
  deletion_policy = "ABANDON"
}