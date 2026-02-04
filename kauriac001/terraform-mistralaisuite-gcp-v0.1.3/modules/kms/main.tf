resource "google_kms_key_ring" "main" {
  count    = var.kms_create ? 1 : 0
  name     = var.key_ring_name
  location = var.region
  project  = var.project_id
}

resource "google_kms_crypto_key" "main" {
  count           = var.kms_create ? 1 : 0
  name            = var.crypto_key_name
  key_ring        = google_kms_key_ring.main.0.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "2592000s" # 30 days
  lifecycle {
    prevent_destroy = false
  }
  version_template {
    algorithm = "GOOGLE_SYMMETRIC_ENCRYPTION"
  }
}

resource "google_project_service_identity" "sqladmin" {
  provider = google-beta
  count    = var.managed_database_create ? 1 : 0
  project  = var.project_id
  service  = "sqladmin.googleapis.com"
}

data "google_project" "main" {}


resource "google_kms_crypto_key_iam_binding" "cloudkms" {
  crypto_key_id = var.kms_create ? google_kms_crypto_key.main.0.id : var.crypto_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  members = concat([
    "serviceAccount:${var.service_account_email}",
    "serviceAccount:service-${data.google_project.main.number}@container-engine-robot.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.main.number}@cloud-filer.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.main.number}@compute-system.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.main.number}@gs-project-accounts.iam.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.main.number}@gcp-sa-gkebackup.iam.gserviceaccount.com",
  ], var.managed_database_create ? ["serviceAccount:${google_project_service_identity.sqladmin.0.email}"] : [])
}