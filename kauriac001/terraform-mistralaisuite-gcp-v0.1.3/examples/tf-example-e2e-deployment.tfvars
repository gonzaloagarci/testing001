project_id = "mistral-sa"
region = "us-central1"
zone = "us-central1-a"
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

# Cluster configuration
cluster_create = true
cluster_autopilot = false
cluster_use_calculator = false
cluster_node_zones = ["us-central1-a"]
cluster_release_channel = "REGULAR"

# CPU configuration
cluster_cpu_node_min_count = 2
cluster_cpu_node_max_count = 4
cluster_cpu_node_use_preemptible = false
cluster_cpu_node_type = "n1-standard-32"
cluster_cpu_node_disk_size_gb = 150

# GPU configuration
cluster_gpu_node_min_count = 1
cluster_gpu_node_max_count = 3
cluster_gpu_node_gpu_type = "nvidia-tesla-a100"
cluster_gpu_node_gpu_count = 1
cluster_gpu_node_use_preemptible = true
cluster_gpu_node_type = "a2-highgpu-1g"
cluster_gpu_node_disk_size_gb = 200
cluster_gpu_node_local_ssd_count = 2
cluster_gpu_node_tags = ["gpu-t4-nodes"]
cluster_gpu_driver_version = "INSTALLATION_DISABLED"

# Bucket configuration
bucket_models_create = false
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
gpu_operator_namespace = "gpu-operator"
gpu_operator_chart_install = true
# gpu_operator_chart_version = "v25.3.2"
# gpu_operator_driver_version = "580.65.06"
# gpu_operator_toolkit_version = "v1.17.8-ubuntu20.04"

gpu_operator_chart_version = "v24.9.0"
gpu_operator_driver_version = "570.133.20"
gpu_operator_toolkit_version = "v1.13.1-ubuntu20.04"

# Cert manager
cert_manager_namespace = "cert-manager"
cert_manager_create = true
cert_manager_acme_email = "cert@demoonprem.app"



