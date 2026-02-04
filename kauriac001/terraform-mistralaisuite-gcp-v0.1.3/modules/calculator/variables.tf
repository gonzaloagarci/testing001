#### General Variables ####

variable "cloud_tenant_id" {
  type        = string
  description = "Cloud Tenant ID. Either AWS Profile, Azure Subscription ID, or GCP Project ID"
}

variable "cloud_region" {
  type        = string
  description = "Cloud Provider Region"
}

variable "cloud_provider_name" {
  description = "Cloud Provider Name"
  type        = string
  validation {
    condition     = contains(["aws", "azure", "gcp"], var.cloud_provider_name)
    error_message = "Cloud Provider Name must be one of: aws, azure, gcp"
  }
}

#### Cluster Variables ####

variable "cpu_node_type" {
  type        = string
  description = "CPU Node Type"
}

variable "gpu_node_type" {
  type        = string
  description = "GPU Node Type"
}

#### Mistral AI Suite Chart Variables ####

variable "mistral_ai_suite_chart_uri" {
  type        = string
  description = "Mistral AI Suite Helm Chart URI"
  default     = "oci://cdn-images.mistralai.com/helm/mistral-ai-suite"
}

variable "mistral_ai_suite_chart_version" {
  type        = string
  description = "Mistral AI Suite Helm Chart Version"
  default     = "1.3.6"
}

variable "mistral_ai_suite_chart_values_files" {
  type        = list(string)
  description = "Mistral AI Suite Helm Chart Values Files"
  default     = ["values.yaml"]
}
