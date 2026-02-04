environment = "xxe"
host_project_id = "gc-pr-xxe-7434-internal-sh-vpc"
seed_project_id = "gc-pr-xxe-7765-kaur-mistral"
random_string_length = 8
random_string_special = false
project_id = "gc-pr-xxe-7765-kaur-mistral"
region = "europe-southwest1"
prefix = "mistral-ai-suite-"
network_vpc_create = false
network_vpc_name = "gc-sh-vpc-xxe-internal-base-spoke"
network_vpc_name_selflink = "projects/gc-pr-xxe-7434-internal-sh-vpc/global/networks/gc-sh-vpc-xxe-internal-base-spoke"
network_subnet_name = "gc-sh-vpc-sb-xxe-internal-base-spoke-264630099942-eu-sw1"
network_subnet_selflink = "projects/gc-pr-xxe-7434-internal-sh-vpc/regions/europe-southwest1/subnetworks/gc-sh-vpc-sb-xxe-internal-base-spoke-264630099942-eu-sw1"
network_pods_subnet_name = "gc-sh-vpc-sb-xxe-internal-base-spoke-264630099942-eu-sw1-1"
network_lb_subnet_name = "gc-sh-vpc-sb-xxe-internal-base-spoke-264630099942-eu-sw1-2"
network_private_endpoint_subnet_selflink = "projects/gc-pr-xxe-7434-internal-sh-vpc/regions/europe-southwest1/subnetworks/gc-sh-vpc-sb-xxe-internal-base-spoke-264630099942-eu-sw1-2"
apisix_load_balancer_ip_name = "gc-int-lb-xxe-internal-base-spoke-264630099942-eu-sw1-2"
apisix_load_balancer_ip_address = "172.24.119.227"
network_nat_create = false
network_subnet_ip_cidr_range_nodes = null
network_subnet_ip_cidr_range_pods = null
network_subnet_ip_cidr_range_services = null
kms_create = true
kms_crypto_key_id = ""
iam_create = false
iam_service_account_email = "gc-sa-xxe-kaur-gke-cluster-acc@gc-pr-xxe-7765-kaur-mistral.iam.gserviceaccount.com"
# iam_service_account_creds = ""
#workload_identity_bindings = [
#  {
#    namespace   = "mistral-ai-suite"
#    k8s_sa_name = "mai-suite-tempo"
#  },
#  {
#    namespace   = "mistral-ai-suite"
#    k8s_sa_name = "mai-suite-dashboard"
#  },
#  {
#    namespace   = "mistral-ai-suite"
#    k8s_sa_name = "mai-suite-albe-cnpg"
#  },
#  {
#    namespace   = "mistral-ai-suite"
#    k8s_sa_name = "mai-suite-dashboard-cnpg"
#  }
#]
workload_identity_bindings = []
cluster_create = true
cluster_autopilot = false
# Zones for GKE cluster nodes and regional persistent disk topology
cluster_node_zones = ["europe-southwest1-a", "europe-southwest1-b", "europe-southwest1-c"]
cluster_release_channel = "UNSPECIFIED"
cluster_kubernetes_version = "1.33.5"
cluster_kubernetes_general_node_version = "1.33.5-gke.1162000"
cluster_kubernetes_internal_node_version = "1.33.5-gke.1162000"
cluster_node_pool_auto_upgrade = false
cluster_cpu_node_disk_size_gb = 150
cluster_cpu_node_pool_name = "tf-general-cpu-pool"
initial_node_count_per_zone = 1
cluster_cpu_node_min_count = 3
cluster_cpu_node_max_count = 6
cluster_cpu_node_use_preemptible = false
cluster_cpu_node_type = "n2-standard-32"
cluster_cpu_node_tags = ["general-cpu-nodes",  "gc-nsg-from-onprem", "cpu-nodes"]
cluster_resource_manager_tags = []
cluster_gpu_reservation_name = ""
cluster_gpu_node_min_count = 0
cluster_gpu_node_max_count = 0
cluster_gpu_node_gpu_type = "nvidia-h100-80gb"
cluster_gpu_node_gpu_count = 0
cluster_gpu_node_use_preemptible = false
cluster_gpu_node_type = "a3-highgpu-4g"
cluster_gpu_node_disk_size_gb = 150
cluster_gpu_node_local_ssd_count = 8
cluster_gpu_node_tags = ["gpu-nodes"]
cluster_gpu_driver_version = "INSTALLATION_DISABLED"

# Internal IT CPU Node Pool Configuration
cluster_internal_cpu_node_pool_name       = "tf-internal-cpu-pool"
cluster_internal_cpu_node_min_count       = 2
cluster_internal_cpu_node_max_count       = 4
cluster_internal_cpu_node_type            = "n2-standard-16"
cluster_internal_cpu_node_disk_size_gb    = 150
cluster_internal_cpu_node_use_preemptible = false
cluster_internal_cpu_node_tags            = ["internal-cpu-nodes", "gc-nsg-from-onprem", "gc-nsg-to-onprem", "cpu-nodes"]
cluster_internal_cpu_node_taints          = [
  {
    key    = "network"
    value  = "internal-it-only"
    effect = "NO_SCHEDULE"
  }
]
bucket_models_create = false
bucket_apps_create = true
bucket_backups_create = true
bucket_storage_class = "STANDARD"
bucket_force_destroy = true
bucket_versioning_enabled = true
bucket_uniform_level_access = true
nfs_create = false
nfs_tier = "REGIONAL"
nfs_protocol = "NFS_V4_1"
nfs_capacity_gb = 2560
managed_database_create = false
gpu_operator_chart_install = false
gpu_operator_chart_version = "v24.9.0"
gpu_operator_driver_version = "570.133.20"
gpu_operator_namespace = "gpu-operator"
gpu_operator_toolkit_version = "v1.13.1-ubuntu20.04"

#Abanca Custom Vars
enable_secure_boot = true
enable_integrity_monitoring = true
enable_private_nodes    = true
enable_private_endpoint = true

