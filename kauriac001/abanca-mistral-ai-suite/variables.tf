variable "gcp_credentials_file" {
  description = "Archivo que contiene las credenciales de la cuenta de terraform utilizada para realizar el desplieuge"
}

variable "host_project_id" {
  type        = string
  description = "GCP Shared VPC Host Project ID"
}

variable "seed_project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "terraform_project_email" {
  type        = string
  description = "Cuenta de servicio asociada al proyectoA"
}

variable "random_string_length" {
  type        = number
  description = "The length of the string desired. The minimum value for length is 1 and, length must also be >= (min_upper + min_lower + min_numeric + min_special)."
}

variable "random_string_special" {
  type        = bool
  description = "Include special characters in the result. These are !@#$%&*()-_=+[]{}<>:?. Default value is true"
}

#### General Variables ####

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
  default     = "europe-west4"
}

variable "default_labels" {
  type        = map(string)
  description = "Default Labels to apply to all resources"
  default     = {}
}

variable "prefix" {
  type        = string
  description = "Prefix to apply to all resources"
  default     = "mistral-ai-suite-"
  validation {
    condition     = can(regex(".*[^\\-]-$", var.prefix))
    error_message = "Prefix must end with a single dash character (-)"
  }
}

#### Network Variables ####

variable "network_vpc_create" {
  type        = bool
  description = "Network VPC Creation flag. Set to true to create a new VPC"
  default     = true
}

variable "network_vpc_name" {
  type        = string
  description = "Network VPC Name"
  default     = ""
}

variable "network_subnet_name" {
  type        = string
  description = "Network Subnetwork Name"
  default     = ""
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

variable "apisix_load_balancer_ip_name" {
  type        = string
  description = "Name for the APISIX load balancer IP address resource"
}

variable "apisix_load_balancer_ip_address" {
  type        = string
  description = "Specific internal IP address for the APISIX load balancer"
}

variable "network_subnet_ip_cidr_range_nodes" {
  type        = string
  description = "Network Subnetwork IP CIDR Range for Nodes"
  default     = "10.0.0.0/20"
}

variable "network_subnet_ip_cidr_range_pods" {
  type        = string
  description = "Network Subnetwork IP CIDR Range for Pods"
  default     = "10.1.0.0/16"
}

variable "network_subnet_ip_cidr_range_services" {
  type        = string
  description = "Network Subnetwork IP CIDR Range for Services"
  default     = "10.2.0.0/16"
}

variable "network_vpc_name_selflink" {
  type        = string
  description = "Network VPC selflink"
}

variable "network_subnet_selflink" {
  type        = string
  description = "Network Subnet selflink"
}

variable "network_private_endpoint_subnet_selflink" {
  type        = string
  description = "Network Private Endpoint selflink"
}

variable "network_nat_create" {
  type        = bool
  description = "Flag to create Cloud NAT for egress internet access. Required for pulling docker images from external registries"
  default     = true
}

#### KMS Variables ####

variable "kms_create" {
  type        = bool
  description = "KMS Creation flag. Set to true to create a KMS Keyring and Crypto Key"
  default     = true
}

variable "kms_crypto_key_id" {
  type        = string
  description = "KMS Crypto Key ID"
  default     = ""
}

#### IAM Variables ####

variable "iam_create" {
  type        = bool
  description = "IAM Creation flag. Set to true to create IAM Roles and Bindings. Or provide your own IAM Roles and Bindings"
  default     = true
}

variable "iam_service_account_email" {
  type        = string
  description = "IAM Service Account Email"
  default     = ""
}

variable "iam_service_account_creds" {
  type        = string
  description = "IAM Service Account Credentials"
  default     = ""
  sensitive   = true
}

variable "workload_identity_bindings" {
  type = list(object({
    namespace   = string
    k8s_sa_name = string
  }))
  description = "List of Kubernetes service accounts that need Workload Identity bindings to the GCP service account"
  default     = []
}

#### Cluster Variables ####

variable "cluster_create" {
  type        = bool
  description = "Cluster Creation flag. Set to true to create a new Cluster"
  default     = true
}

variable "cluster_autopilot" {
  type        = bool
  description = "Cluster Autopilot mode. Bypasses the Resource Calculator"
  default     = false
}

variable "cluster_node_zones" {
  type        = list(string)
  description = "Cluster Node Zones"
  default     = []
}

variable "cluster_kubernetes_version" {
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


variable "cluster_release_channel" {
  type        = string
  description = "Cluster Release Channel"
}

variable "cluster_node_pool_auto_upgrade" {
  type        = bool
  description = "Whether to enable auto-upgrade for node pools"
  default     = false
}

variable "cluster_cpu_node_pool_name" {
  type        = string
  description = "Cluster General CPU Node Pool Name"
  default     = "tf-general-cpu-pool"
}

variable "initial_node_count_per_zone" {
  type        = number
  description = "CPU Node Min Count per zone"
  default     = 1
}

variable "cluster_cpu_node_min_count" {
  type        = number
  description = "Cluster CPU Node Min Count"
  default     = 1
}

variable "cluster_cpu_node_max_count" {
  type        = number
  description = "Cluster CPU Node Max Count"
  default     = 2
}

variable "cluster_cpu_node_use_preemptible" {
  type        = bool
  description = "Cluster CPU Node Use Preemptible instances"
  default     = false
}

variable "cluster_cpu_node_type" {
  type        = string
  description = "Cluster CPU Node Type"
  default     = "n1-standard-32"
}

variable "cluster_cpu_node_disk_size_gb" {
  type        = number
  description = "Cluster CPU Node Disk Size GiB"
  default     = 150
}

variable "cluster_cpu_node_tags" {
  type        = list(string)
  description = "Cluster CPU Node Tags to apply to all nodes"
  default     = []
}

variable "cluster_resource_manager_tags" {
  type        = list(string)
  description = "Cluster Resource manager tags"
  default     = []
}

variable "cluster_gpu_reservation_name" {
  type        = string
  description = "Cluster GPU Reservation Name"
  default     = ""
  validation {
    condition     = var.cluster_gpu_reservation_name == "" || can(regex("^projects/.*/reservations/.*$", var.cluster_gpu_reservation_name))
    error_message = "Cluster GPU Reservation Name Must be of the form \"projects/[PROJECT_ID]/reservations/[RESERVATION_NAME]\""
  }
}

variable "cluster_gpu_node_min_count" {
  type        = number
  description = "Cluster GPU Node Min Count"
  default     = 1
}

variable "cluster_gpu_node_max_count" {
  type        = number
  description = "Cluster GPU Node Max Count"
  default     = 1
}

variable "cluster_gpu_node_gpu_type" {
  type        = string
  description = "Cluster GPU Node GPU Type"
  default     = "nvidia-h100-80gb"
}

variable "cluster_gpu_node_gpu_count" {
  type        = number
  description = "Cluster GPU Node GPU Count"
  default     = 4
}

variable "cluster_gpu_node_use_preemptible" {
  type        = bool
  description = "Cluster GPU Node Use Preemptible instances"
  default     = false
}

variable "cluster_gpu_node_type" {
  type        = string
  description = "Cluster GPU Node Type"
  default     = "a3-highgpu-4g"
}

variable "cluster_gpu_node_disk_size_gb" {
  type        = number
  description = "Cluster GPU Node Disk Size GiB"
  default     = 150
}

variable "cluster_gpu_node_local_ssd_count" {
  type        = number
  description = "Cluster GPU Node Local SSD Count"
  default     = 8
}

variable "cluster_gpu_node_tags" {
  type        = list(string)
  description = "Cluster GPU Node Tags to apply to all nodes"
  default     = []
}

variable "cluster_gpu_driver_version" {
  type        = string
  description = "Cluster GPU Driver Version"
  default     = "INSTALLATION_DISABLED"
}

#### Internal IT CPU Node Pool Variables ####

variable "cluster_internal_cpu_node_pool_name" {
  type        = string
  description = "Cluster Internal IT CPU Node Pool Name"
  default     = "tf-internal-cpu-pool"
}

variable "cluster_internal_cpu_node_min_count" {
  type        = number
  description = "Cluster Internal IT CPU Node Min Count"
  default     = 0
}

variable "cluster_internal_cpu_node_max_count" {
  type        = number
  description = "Cluster Internal IT CPU Node Max Count"
  default     = 0
}

variable "cluster_internal_cpu_node_type" {
  type        = string
  description = "Cluster Internal IT CPU Node Type"
  default     = "n2-standard-16"
}

variable "cluster_internal_cpu_node_disk_size_gb" {
  type        = number
  description = "Cluster Internal IT CPU Node Disk Size GiB"
  default     = 150
}

variable "cluster_internal_cpu_node_use_preemptible" {
  type        = bool
  description = "Cluster Internal IT CPU Node Use Preemptible instances"
  default     = false
}

variable "cluster_internal_cpu_node_tags" {
  type        = list(string)
  description = "Cluster Internal IT CPU Node Tags to apply to all nodes"
  default     = []
}

variable "cluster_internal_cpu_node_taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  description = "Cluster Internal IT CPU Node Taints"
  default     = []
}

#### GPU Operator Chart Variables ####

variable "gpu_operator_namespace" {
  type        = string
  description = "Helm GPU Operator Namespace"
  default     = "gpu-operator"
}

variable "gpu_operator_chart_install" {
  type        = bool
  description = "Helm GPU Operator Install Driver flag. Set to true to install the NVIDIA Driver"
  default     = true
}

variable "gpu_operator_chart_version" {
  type        = string
  description = "Helm GPU Operator Version. Not set when `nvaie` is set to `true`"
  default     = "v24.9.0"
}

variable "gpu_operator_driver_version" {
  type        = string
  description = "Helm GPU Operator NVIDIA Driver Version"
  default     = "570.133.20"
}

variable "gpu_operator_toolkit_version" {
  type        = string
  description = "Helm GPU Operator Toolkit Version"
  default     = "v1.13.1-ubuntu20.04"
}

#### Buckets Variables ####

variable "bucket_models_create" {
  type        = bool
  description = "Bucket Models Create flag. Set to true to create a Bucket for Models"
  default     = true
}

variable "bucket_apps_create" {
  type        = bool
  description = "Bucket Apps Create flag. Set to true to create a Bucket for Apps"
  default     = true
}

variable "bucket_backups_create" {
  type        = bool
  description = "Bucket Backups Create flag. Set to true to create a Bucket for Backups"
  default     = true
}

variable "bucket_storage_class" {
  type        = string
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "bucket_force_destroy" {
  type        = bool
  description = "Bucket Force Destroy flag. Set to true to force-destroy the bucket content on destroy"
  default     = true
}

variable "bucket_versioning_enabled" {
  type        = bool
  description = "Bucket Versioning Enabled flag. Set to true to enable versioning"
  default     = false
}

variable "bucket_uniform_level_access" {
  type        = bool
  description = "Bucket Uniform Level Access flag"
}

#### NFS Variables ####

variable "nfs_create" {
  type        = bool
  description = "NFS Creation flag. Set to true to create a Filestore Instance"
  default     = true
}

variable "nfs_tier" {
  type        = string
  description = "NFS Tier"
  default     = "REGIONAL"
}

variable "nfs_protocol" {
  type        = string
  description = "NFS Protocol version"
  default     = "NFS_V4_1"
}

variable "nfs_capacity_gb" {
  type        = number
  description = "NFS Capacity in GiB"
  default     = 2560
}

#### Database Variables ####

variable "managed_database_create" {
  type        = bool
  description = "Managed Database Creation flag. Set to true to create a Managed PostgreSQL Instance"
  default     = true
}
variable "enable_secure_boot" {
  type        = bool
  description = "enable_secure_boot"
}

variable "enable_integrity_monitoring" {
  type        = bool
  description = "enable_integrity_monitoring"
}

variable "enable_private_nodes" {
  type        = bool
  description = "enable_private_nodes"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "enable_private_endpoint"
}
variable "alert_notification_email" {
  description = "Email para recibir alertas críticas de infraestructura"
  type        = string
  default     = "cloud-admins-alerts@abanca.com" # <--- Cambia esto o pásalo en tu .tfvars
}
