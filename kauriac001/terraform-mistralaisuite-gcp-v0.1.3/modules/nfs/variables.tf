variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "name" {
  type        = string
  description = "Name"
}

variable "tier" {
  type        = string
  description = "Tier"
  default     = "REGIONAL"
}

variable "protocol" {
  type        = string
  description = "Protocol version"
  default     = "NFS_V4_1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "kms_crypto_key_id" {
  type        = string
  description = "KMS Crypto Key ID to encrypt the NFS volume"
  default     = ""
}

variable "service_account_email" {
  type        = string
  description = "Service Account Email"
}
