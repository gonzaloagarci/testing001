variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "name" {
  type        = string
  description = "Service Account Name"
}

variable "description" {
  type        = string
  description = "Service Account Description"
  default     = "Mistral AI Suite Service Account"
}

variable "create_service_account" {
  type        = bool
  description = "Whether to create a new service account. If false, service_account_email must be provided."
  default     = true
}

variable "service_account_email" {
  type        = string
  description = "Email of existing service account to use (when create_service_account = false)"
  default     = ""
}

variable "workload_identity_bindings" {
  type = list(object({
    namespace      = string
    k8s_sa_name    = string
  }))
  description = "List of Kubernetes service accounts that need Workload Identity bindings"
  default     = []
}
