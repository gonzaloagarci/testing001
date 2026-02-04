resource "google_storage_bucket" "models" {
  count                       = var.models_create ? 1 : 0
  name                        = var.models_name
  project                     = var.project_id
  location                    = var.region
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_level_access
  versioning {
    enabled = var.versioning_enabled
  }
  encryption {
    default_kms_key_name = var.kms_crypto_key_id
  }
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "apps" {
  count                       = var.apps_create ? 1 : 0
  name                        = var.apps_name
  project                     = var.project_id
  location                    = var.region
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_level_access
  versioning {
    enabled = var.versioning_enabled
  }
  encryption {
    default_kms_key_name = var.kms_crypto_key_id
  }
  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "backups" {
  count                       = var.backups_create ? 1 : 0
  name                        = var.backups_name
  project                     = var.project_id
  location                    = var.region
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_level_access
  versioning {
    enabled = var.versioning_enabled
  }
  encryption {
    default_kms_key_name = var.kms_crypto_key_id
  }
  public_access_prevention = "enforced"
}

resource "google_storage_bucket_iam_member" "models_admin" {
  count      = var.models_create ? 1 : 0
  bucket     = var.models_name
  role       = "roles/storage.objectAdmin"
  member     = "serviceAccount:${var.service_account_email}"
  depends_on = [google_storage_bucket.models]
}

resource "google_storage_bucket_iam_member" "apps_admin" {
  count      = var.apps_create ? 1 : 0
  bucket     = var.apps_name
  role       = "roles/storage.objectAdmin"
  member     = "serviceAccount:${var.service_account_email}"
  depends_on = [google_storage_bucket.apps]
}

resource "google_storage_bucket_iam_member" "backups_admin" {
  count      = var.backups_create ? 1 : 0
  bucket     = var.backups_name
  role       = "roles/storage.objectAdmin"
  member     = "serviceAccount:${var.service_account_email}"
  depends_on = [google_storage_bucket.backups]
}
