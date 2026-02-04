variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "kms_create" {
  type        = bool
  description = "KMS Create flag. Set to true to create a KMS key ring and crypto key"
  default     = false
}

variable "key_ring_name" {
  type        = string
  description = "Key Ring Name"
  default     = "mistral-ai-suite-keyring"
}

variable "crypto_key_name" {
  type        = string
  description = "Crypto Key Name"
  default     = "mistral-ai-suite-key"
}

variable "crypto_key_id" {
  type        = string
  description = "Crypto Key ID"
  default     = ""
}

variable "service_account_email" {
  type        = string
  description = "Service Account Email that will be granted access to the KMS key"
  default     = ""
}

variable "managed_database_create" {
  type        = bool
  description = "Database Create flag. Set to true to create a managed database"
  default     = false
}
