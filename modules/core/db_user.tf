resource "random_password" "db_password" { # Generated default DB password
    length = 10
    special = true
    override_special = "!#$%&*()-_=+[]{}<>:"
}

resource "google_sql_user" "db_user" {
  name     = var.DB_ROOT_USERNAME
  instance = google_sql_database_instance.db_instance.name
  password = "${var.DB_PASSWORD != "" ? var.DB_PASSWORD : random_password.db_password.result}" # If unset, will choose the random generated one
}