output "models_name" {
  description = "Bucket Models Name"
  value       = var.models_create ? google_storage_bucket.models.0.name : null
}

output "models_url" {
  description = "Bucket Models URL"
  value       = var.models_create ? google_storage_bucket.models.0.url : null
}

output "models_location" {
  description = "Bucket Models Location"
  value       = var.models_create ? google_storage_bucket.models.0.location : null
}

output "apps_name" {
  description = "Bucket Apps Name"
  value       = var.apps_create ? google_storage_bucket.apps.0.name : null
}

output "apps_url" {
  description = "Bucket Apps URL"
  value       = var.apps_create ? google_storage_bucket.apps.0.url : null
}

output "apps_location" {
  description = "Bucket Apps Location"
  value       = var.apps_create ? google_storage_bucket.apps.0.location : null
}

output "backups_name" {
  description = "Bucket Backups Name"
  value       = var.backups_create ? google_storage_bucket.backups.0.name : null
}

output "backups_url" {
  description = "Bucket Backups URL"
  value       = var.backups_create ? google_storage_bucket.backups.0.url : null
}

output "backups_location" {
  description = "Bucket Backups Location"
  value       = var.backups_create ? google_storage_bucket.backups.0.location : null
}
