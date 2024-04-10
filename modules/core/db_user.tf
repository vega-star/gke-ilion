resource "random_password" "db_password" { # Generated default DB password
    length = 10
    special = true
    override_special = "!#$%&*()-_=+[]{}<>:"
}

locals {
  db_password = var.DB_PASSWORD != "" ? var.DB_PASSWORD : random_password.db_password.result
}

resource "google_sql_user" "db_user" {
  name     = "ilion_db_user"
  instance = google_sql_database_instance.db_instance.name
  password = var.DB_PASSWORD
}