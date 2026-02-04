data "google_compute_network" "main" {
  name = var.vpc_name
}

resource "google_sql_database_instance" "main" {
  region              = var.region
  project             = var.project_id
  name                = var.name
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  encryption_key_name = var.kms_crypto_key_id
  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size
    disk_type         = var.disk_type
    disk_autoresize   = true
    password_validation_policy {
      min_length                  = 30
      reuse_interval              = 90
      disallow_username_substring = true
      enable_password_policy      = true
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = data.google_compute_network.main.id
      ssl_mode        = "ENCRYPTED_ONLY"
    }
    backup_configuration {
      enabled    = true
      start_time = "02:00"
    }
    maintenance_window {
      day  = 7
      hour = 2
    }
  }
}

resource "google_sql_database" "main" {
  project  = var.project_id
  name     = var.database_name
  instance = google_sql_database_instance.main.name
}

resource "random_password" "password" {
  length = 30
  special = false
}

resource "google_sql_user" "main" {
  project  = var.project_id
  name     = "mistral"
  instance = google_sql_database_instance.main.name
  password = random_password.password.result
}

resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.service_account_email}"
}
