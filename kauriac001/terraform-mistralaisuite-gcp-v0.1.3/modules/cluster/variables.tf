variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "host_project_id" {
  type        = string
  description = "GCP Shared VPC Host Project ID"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "europe-west4"
}

variable "autopilot" {
  type        = bool
  default     = false
  description = "Whether to enable GKE autopilot or not"
}

variable "name" {
  type        = string
  description = "Cluster Name"
}

variable "cluster_release_channel" {
  type        = string
  description = "Cluster Release Channel"
}

variable "node_zones" {
  type        = list(string)
  description = "Node Zones"
  default     = []
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version for the cluster master"
  default     = null
}

variable "cluster_kubernetes_general_node_version" {
  type        = string
  description = "Kubernetes version for the cluster node pools"
  default     = null
}

variable "cluster_kubernetes_internal_node_version" {
  type        = string
  description = "Kubernetes version for the cluster node pools"
  default     = null
}

variable "node_pool_auto_upgrade" {
  type        = bool
  description = "Whether to enable auto-upgrade for node pools"
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "Deletion Protection"
  default     = false
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "default"
}

variable "subnet_name" {
  type        = string
  description = "Subnetwork Name"
  default     = null
}

variable "network_pods_subnet_name" {
  type        = string
  description = "Network Pods Subnetwork Name"
  default     = ""
}

variable "network_lb_subnet_name" {
  type        = string
  description = "Network LB Subnetwork Name"
  default     = ""
}

variable "subnet_ip_cidr_range_pods" {
  type        = string
  description = "Subnetwork IP CIDR Range for Pods"
  default     = null
}

variable "subnet_ip_cidr_range_services" {
  type        = string
  description = "Subnetwork IP CIDR Range for Services"
  default     = null
}

variable "network_subnet_ip_cidr_range_master" {
  type        = string
  description = "Network Subnetwork IP CIDR Range for Master / Control Plane"
  default     = null
}

variable "network_vpc_name_selflink" {
  type        = string
  description = "Network VPC selflink"
  default     = null
}

variable "network_subnet_selflink" {
  type        = string
  description = "Network Subnetwork selflink (full path: projects/{project}/regions/{region}/subnetworks/{name})"
  default     = null
}

variable "network_private_endpoint_subnet_selflink" {
  type        = string
  description = "Network Private Endpoint Subnetwork selflink (full path: projects/{project}/regions/{region}/subnetworks/{name})"
}


variable "kms_crypto_key_id" {
  type        = string
  description = "KMS Crypto Key ID"
  default     = ""
}

variable "enable_secure_boot" {
  type        = bool
  description = "Enable Secure Boot. Not compatible with the GPU operator. To keep at false if you want to use the GPU operator."
  default     = false
}

variable "enable_integrity_monitoring" {
  type        = bool
  description = "Enable Integrity Monitoring"
  default     = true
}

variable "service_account_email" {
  type        = string
  description = "Service Account Email"
}

variable "cpu_node_pool_name" {
  type        = string
  description = "CPU Node Pool Name"
}

variable "initial_node_count_per_zone" {
  type        = number
  description = "CPU Node Min Count per zone"
  default     = 1
}

variable "cpu_node_min_count" {
  type        = number
  description = "CPU Node Min Count"
  default     = 1
}

variable "cpu_node_max_count" {
  type        = number
  description = "CPU Node Max Count"
  default     = 1
}

variable "cpu_node_use_preemptible" {
  type        = bool
  description = "CPU Node Use Preemptible instances"
  default     = false
}

variable "cpu_node_type" {
  type        = string
  description = "CPU Node Type"
  default     = "n1-standard-1"
}

variable "cpu_node_disk_size_gb" {
  type        = number
  description = "CPU Node Disk Size in GiB"
  default     = 150
}

variable "cluster_cpu_node_tags" {
  type        = list(string)
  description = "CPU Node Tags"
  default     = []
}

variable "cluster_resource_manager_tags" {
  type        = list(string)
  description = "Cluster Resource manager tags"
  default     = []
}

variable "gpu_node_pool_name" {
  type        = string
  description = "GPU Node Pool Name"
}

variable "gpu_node_min_count" {
  type        = number
  description = "GPU Node Min Count"
  default     = 1
}

variable "gpu_node_max_count" {
  type        = number
  description = "GPU Node Max Count"
  default     = 1
}

variable "gpu_node_local_ssd_count" {
  type        = number
  description = "GPU Node Local SSD Count"
  default     = 0
}

variable "gpu_node_gpu_type" {
  type        = string
  description = "GPU Node GPU Type"
  default     = "nvidia-h100-80gb"
}

variable "gpu_node_gpu_count" {
  type        = number
  description = "GPU Node GPU Count"
  default     = 1
}

variable "gpu_node_use_preemptible" {
  type        = bool
  description = "GPU Node Use Preemptible instances"
  default     = false
}

variable "gpu_driver_version" {
  type        = string
  description = "GPU Driver Version"
  default     = "LATEST"
}

variable "gpu_node_type" {
  type        = string
  description = "GPU Node Type"
  default     = "a3-highgpu-1g"
}

variable "gpu_node_disk_size_gb" {
  type        = number
  description = "GPU Node Disk Size in GiB"
  default     = 150
}

variable "gpu_node_tags" {
  type        = list(string)
  description = "GPU Node Tags"
  default     = []
}

variable "gpu_reservation_name" {
  type        = string
  description = "GPU Reservation Name"
  default     = ""
  validation {
    condition     = var.gpu_reservation_name == "" || can(regex("^projects/.*/reservations/.*$", var.gpu_reservation_name))
    error_message = "GPU Reservation Name Must be of the form \"projects/[PROJECT_ID]/reservations/[RESERVATION_NAME]\""
  }
}

variable "internal_cpu_node_pool_name" {
  type        = string
  description = "Internal IT CPU Node Pool Name"
}

variable "internal_cpu_node_min_count" {
  type        = number
  description = "Internal IT CPU Node Min Count"
  default     = 0
}

variable "internal_cpu_node_max_count" {
  type        = number
  description = "Internal IT CPU Node Max Count"
  default     = 0
}

variable "internal_cpu_node_type" {
  type        = string
  description = "Internal IT CPU Node Type"
  default     = "n2-standard-16"
}

variable "internal_cpu_node_disk_size_gb" {
  type        = number
  description = "Internal IT CPU Node Disk Size in GiB"
  default     = 150
}

variable "internal_cpu_node_tags" {
  type        = list(string)
  description = "Internal IT CPU Node Tags"
  default     = []
}

variable "internal_cpu_node_taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Internal IT CPU Node Taints"
  default     = []
}

variable "internal_cpu_node_use_preemptible" {
  type        = bool
  description = "Internal IT CPU Node Use Preemptible instances"
  default     = false
}

variable "enable_private_nodes" {
  type        = bool
  description = "enable_private_nodes"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "enable_private_endpoint"
}
