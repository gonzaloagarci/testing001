output "crypto_key_id" {
  description = "Crypto Key ID"
  value       = var.kms_create ? google_kms_crypto_key.main.0.id : var.crypto_key_id
}
