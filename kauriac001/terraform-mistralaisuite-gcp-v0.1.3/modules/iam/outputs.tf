output "service_account_email" {
  description = "Service Account Email"
  value       = local.service_account_email
}

output "service_account_name" {
  description = "Service Account Name"
  value       = var.create_service_account ? google_service_account.main[0].name : ""
}

output "service_account_id" {
  description = "Service Account ID"
  value       = var.create_service_account ? google_service_account.main[0].unique_id : ""
}

output "service_account_creds" {
  description = "Service Account Credentials"
  value       = var.create_service_account ? google_service_account_key.main[0].private_key : ""
  sensitive   = true
}
