variable "gpu_node_pool_is_ready" {
  description = "GPU Node Pool Is Ready flag. This is used to ensure that the GPU node pool is ready before installing the GPU operator"
  type        = bool
}

variable "gpu_node_pool_id" {
  description = "GPU Node Pool ID"
  type        = string
}

variable "gpu_operator_namespace" {
  description = "GPU Operator Namespace"
  type        = string
  default     = "gpu-operator"
}

variable "gpu_operator_chart_version" {
  description = "GPU Operator Chart Version"
  type        = string
}

variable "gpu_operator_toolkit_version" {
  description = "GPU Operator Toolkit Version"
  type        = string
}

variable "gpu_operator_driver_version" {
  description = "GPU Operator Driver Version"
  type        = string
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "cloud_provider_name" {
  description = "Cloud Provider Name"
  type        = string
}
