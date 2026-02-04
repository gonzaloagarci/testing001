variable "project_id" {
  description = "Project ID"
  type        = string
}

variable "namespace" {
  description = "Namespace"
  type        = string
  default     = "cert-manager"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-central1"
}

variable "cert_manager_acme_email" {
  description = "ACME Email for Let's Encrypt"
  type        = string
  default     = ""
}

variable "name" {
  type        = string
  description = "Name"
}