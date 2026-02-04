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
  description = "CloudSQL Instance Name"
}

variable "tier" {
  type        = string
  description = "CloudSQL Instance Tier"
  default     = "db-perf-optimized-N-8"
}

variable "availability_type" {
  type        = string
  description = "CloudSQL Instance Availability Type"
  default     = "REGIONAL"
}

variable "disk_size" {
  type        = number
  description = "CloudSQL Instance Disk Size"
  default     = 100
}

variable "disk_type" {
  type        = string
  description = "CloudSQL Instance Disk Type"
  default     = "PD_SSD"
}

variable "deletion_protection" {
  type        = bool
  description = "CloudSQL Instance Deletion Protection flag. Set to true to prevent accidental deletion of the Instance"
  default     = false
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "service_account_email" {
  type        = string
  description = "Service Account Email that will be granted access to the CloudSQL Instance"
}

variable "kms_crypto_key_id" {
  type        = string
  description = "KMS Crypto Key ID to encrypt the CloudSQL Instance Disk"
}

variable "database_name" {
  type        = string
  description = "Database Name"
  default     = "main"
}

variable "database_version" {
  type        = string
  description = "Database Version"
  default     = "POSTGRES_17"
}
