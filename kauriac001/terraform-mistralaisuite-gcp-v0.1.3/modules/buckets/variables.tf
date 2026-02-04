variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "models_create" {
  type        = bool
  description = "Models Bucket Creation flag"
}

variable "apps_create" {
  type        = bool
  description = "Apps Bucket Creation flag"
}

variable "backups_create" {
  type        = bool
  description = "Backups Bucket Creation flag"
}

variable "models_name" {
  type        = string
  description = "Models Bucket Name"
}

variable "apps_name" {
  type        = string
  description = "Apps Bucket Name"
}

variable "backups_name" {
  type        = string
  description = "Backups Bucket Name"
}

variable "storage_class" {
  type        = string
  description = "Bucket Storage Class"
}

variable "force_destroy" {
  type        = bool
  description = "Bucket Force Destroy flag"
}

variable "versioning_enabled" {
  type        = bool
  description = "Bucket Versioning Enabled flag"
}

variable "uniform_level_access" {
  type        = bool
  description = "Bucket Uniform Level Access flag"
}

variable "kms_crypto_key_id" {
  description = "KMS Crypto Key ID to encrypt the Buckets"
  type        = string
  default     = ""
}

variable "service_account_email" {
  description = "Service Account Email that will be granted access to the Buckets"
  type        = string
}
