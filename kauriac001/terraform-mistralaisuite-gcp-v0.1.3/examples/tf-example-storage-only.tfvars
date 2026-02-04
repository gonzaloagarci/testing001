project_id = "mistral-ai-suite"
region = "europe-west4"

default_labels = {
    "owner" = "client-project"
    "reviewer" = "client-it"
}

prefix = "mistral-ai-suite-"

# Network configuration
network_vpc_create = true
network_vpc_name = ""
network_subnet_name = ""
network_nat_create = true
network_subnet_ip_cidr_range_nodes = "10.0.0.0/20"
network_subnet_ip_cidr_range_pods = "10.1.0.0/16"
network_subnet_ip_cidr_range_services = "10.2.0.0/16"

# KMS configuration
kms_create = true
kms_crypto_key_id = ""

# IAM configuration
iam_create = true
iam_service_account_email = ""
iam_service_account_creds = ""

# Cluster configuration
cluster_create = false
cluster_autopilot = false
cluster_node_zones = ["europe-west4-a", "europe-west4-b", "europe-west4-c"]
cluster_release_channel = "REGULAR"

# CPU configuration
cluster_cpu_node_min_count = 1
cluster_cpu_node_max_count = 2
cluster_cpu_node_use_preemptible = false
cluster_cpu_node_type = "n1-standard-32"
cluster_cpu_node_disk_size_gb = 150

# GPU configuration
cluster_gpu_reservation_name = ""
cluster_gpu_node_min_count = 1
cluster_gpu_node_max_count = 1
cluster_gpu_node_gpu_type = "nvidia-h100-80gb"
cluster_gpu_node_gpu_count = 4
cluster_gpu_node_use_preemptible = true
cluster_gpu_node_type = "a3-highgpu-4g"
cluster_gpu_node_disk_size_gb = 150
cluster_gpu_node_local_ssd_count = 8
cluster_gpu_node_tags = ["gpu-smoking-nodes"]
cluster_gpu_driver_version = "INSTALLATION_DISABLED"


# Bucket configuration
bucket_models_create = true
bucket_apps_create = true
bucket_backups_create = true
bucket_storage_class = "STANDARD"
bucket_force_destroy = true
bucket_versioning_enabled = true

# NFS configuration
nfs_create = false
nfs_tier = "REGIONAL"
nfs_protocol = "NFS_V4_1"
nfs_capacity_gb = 2560

# Managed PostgreSQL
managed_database_create = false

# Helm GPU operator
gpu_operator_chart_install = true
gpu_operator_chart_version = "v24.9.0"
gpu_operator_driver_version = "570.133.20"
gpu_operator_namespace = "gpu-operator"
gpu_operator_toolkit_version = "v1.13.1-ubuntu20.04"


