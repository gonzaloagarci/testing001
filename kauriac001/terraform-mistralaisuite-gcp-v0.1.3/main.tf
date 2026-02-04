resource "google_project_service" "main" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "servicenetworking.googleapis.com",
    "sqladmin.googleapis.com",
    "file.googleapis.com",
    "iam.googleapis.com"
  ])
  service            = each.value
  disable_on_destroy = false
}

locals {
  name   = "${var.prefix}${random_string.suffix.result}"
  region = var.region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

/*******************************************************************************
  KMS
*******************************************************************************/

module "kms" {
  source                  = "./modules/kms"
  region                  = var.region
  project_id              = var.project_id
  kms_create              = var.kms_create
  key_ring_name           = "${local.name}-keyring"
  crypto_key_name         = "${local.name}-key"
  crypto_key_id           = var.kms_crypto_key_id
  service_account_email   = local.service_account_email
  managed_database_create = var.managed_database_create

  depends_on = [google_project_service.main]
}

locals {
  kms_crypto_key_id = module.kms.crypto_key_id
}

/*******************************************************************************
  IAM
*******************************************************************************/

module "iam" {
  source                   = "./modules/iam"
  project_id               = var.project_id
  name                     = "${local.name}-sa"
  create_service_account   = var.iam_create
  service_account_email    = var.iam_service_account_email
  workload_identity_bindings = var.workload_identity_bindings

  depends_on = [google_project_service.main]
}

locals {
  service_account_email = module.iam.service_account_email
  service_account_creds = var.iam_create ? module.iam.service_account_creds : var.iam_service_account_creds
}

/*******************************************************************************
  Network
*******************************************************************************/

module "network" {
  source                        = "./modules/network"
  count                         = var.network_vpc_create ? 1 : 0
  region                        = var.region
  project_id                    = var.project_id
  vpc_create                    = var.network_vpc_create
  vpc_name                      = var.network_vpc_create ? "${local.name}-vpc" : var.network_vpc_name
  vpc_peering_name              = "${local.name}-peering"
  subnet_name                   = "${local.name}-subnet"
  subnet_ip_cidr_range_nodes    = var.network_subnet_ip_cidr_range_nodes
  subnet_ip_cidr_range_pods     = var.network_subnet_ip_cidr_range_pods
  subnet_ip_cidr_range_services = var.network_subnet_ip_cidr_range_services
  nat_create                    = var.network_nat_create
  nat_name                      = "${local.name}-nat"
  router_name                   = "${local.name}-router"
  load_balancer_ip_create       = true
  load_balancer_ip_name         = "mistral-workflows-lb-ip"

  depends_on = [google_project_service.main]
}

locals {
  vpc_name = var.network_vpc_create ? module.network.0.vpc_name : var.network_vpc_name
}

/*******************************************************************************
  Buckets
*******************************************************************************/

module "buckets" {
  source                = "./modules/buckets"
  region                = var.region
  project_id            = var.project_id
  models_create         = var.bucket_models_create
  models_name           = "${local.name}-models"
  apps_create           = var.bucket_apps_create
  apps_name             = "${local.name}-apps"
  backups_create        = var.bucket_backups_create
  backups_name          = "${local.name}-backups"
  storage_class         = var.bucket_storage_class
  force_destroy         = var.bucket_force_destroy
  versioning_enabled    = var.bucket_versioning_enabled
  uniform_level_access  = var.bucket_uniform_level_access
  kms_crypto_key_id     = local.kms_crypto_key_id
  service_account_email = local.service_account_email
  depends_on            = [module.iam]
}

/*******************************************************************************
  Database
*******************************************************************************/

module "managed_database" {
  source                = "./modules/managed_database"
  count                 = var.managed_database_create ? 1 : 0
  region                = var.region
  project_id            = var.project_id
  name                  = "${local.name}-pg"
  vpc_name              = local.vpc_name
  service_account_email = local.service_account_email
  kms_crypto_key_id     = local.kms_crypto_key_id
  depends_on            = [module.network]
}

/*******************************************************************************
  NFS
*******************************************************************************/

module "nfs" {
  source                = "./modules/nfs"
  count                 = var.nfs_create ? 1 : 0
  region                = var.region
  project_id            = var.project_id
  name                  = "${local.name}-nfs"
  tier                  = var.nfs_tier
  vpc_name              = local.vpc_name
  protocol              = var.nfs_protocol
  service_account_email = local.service_account_email
  kms_crypto_key_id     = local.kms_crypto_key_id
  depends_on            = [module.network]
}


locals {
  cpu_node_min_count = var.cluster_cpu_node_min_count
  cpu_node_max_count = var.cluster_cpu_node_max_count
  gpu_node_min_count = var.cluster_gpu_node_min_count
  gpu_node_max_count = var.cluster_gpu_node_max_count
  node_zones         = var.cluster_node_zones
}

module "apisix_static_ip" {
  source = "./modules/static_lb_ip"

  host_project_id           = var.host_project_id
  project_id                = var.project_id
  region                    = var.region
  subnet_name               = var.network_lb_subnet_name
  load_balancer_ip_name     = var.apisix_load_balancer_ip_name
  load_balancer_ip_address  = var.apisix_load_balancer_ip_address
}

# Use the output in your deployment
output "apisix_loadbalancer_ip" {
  description = "Internal IP address to configure in Apisix Helm chart"
  value       = module.apisix_static_ip.ip_address
}

/*******************************************************************************
  Cluster
*******************************************************************************/

module "cluster" {
  source                        = "./modules/cluster"
  count                         = var.cluster_create ? 1 : 0
  region                        = var.region
  project_id                    = var.project_id
  host_project_id               = var.host_project_id
  name                          = "${local.name}-cluster"
  cluster_release_channel       = var.cluster_release_channel
  autopilot                     = var.cluster_autopilot
  node_zones                    = local.node_zones
  kubernetes_version            = var.cluster_kubernetes_version
  cluster_kubernetes_general_node_version    = var.cluster_kubernetes_general_node_version
  cluster_kubernetes_internal_node_version   = var.cluster_kubernetes_internal_node_version  
  node_pool_auto_upgrade        = var.cluster_node_pool_auto_upgrade
  vpc_name                      = var.network_vpc_create ? module.network.0.vpc_name : var.network_vpc_name
  network_vpc_name_selflink     = var.network_vpc_name_selflink
  subnet_name                   = var.network_vpc_create ? module.network.0.subnet_name : var.network_subnet_name
  network_pods_subnet_name      = var.network_pods_subnet_name
  network_lb_subnet_name        = var.network_lb_subnet_name
  subnet_ip_cidr_range_pods     = var.network_subnet_ip_cidr_range_pods
  subnet_ip_cidr_range_services = var.network_subnet_ip_cidr_range_services
  network_subnet_ip_cidr_range_master = var.network_subnet_ip_cidr_range_master
  kms_crypto_key_id             = local.kms_crypto_key_id
  service_account_email         = local.service_account_email
  cpu_node_pool_name            = var.cluster_cpu_node_pool_name
  initial_node_count_per_zone   = var.initial_node_count_per_zone
  cpu_node_min_count            = local.cpu_node_min_count
  cpu_node_max_count            = local.cpu_node_max_count
  cpu_node_use_preemptible      = var.cluster_cpu_node_use_preemptible
  cpu_node_type                 = var.cluster_cpu_node_type
  cpu_node_disk_size_gb         = var.cluster_cpu_node_disk_size_gb
  cluster_cpu_node_tags         = var.cluster_cpu_node_tags
  cluster_resource_manager_tags = var.cluster_resource_manager_tags
  gpu_node_pool_name            = "tf-gpu-pool"
  gpu_node_min_count            = local.gpu_node_min_count
  gpu_node_max_count            = local.gpu_node_max_count
  gpu_node_local_ssd_count      = var.cluster_gpu_node_local_ssd_count
  gpu_node_use_preemptible      = var.cluster_gpu_node_use_preemptible
  gpu_node_gpu_type             = var.cluster_gpu_node_gpu_type
  gpu_node_gpu_count            = var.cluster_gpu_node_gpu_count
  gpu_node_type                 = var.cluster_gpu_node_type
  gpu_node_disk_size_gb         = var.cluster_gpu_node_disk_size_gb
  gpu_node_tags                 = var.cluster_gpu_node_tags
  gpu_driver_version            = var.cluster_gpu_driver_version
  gpu_reservation_name          = var.cluster_gpu_reservation_name

  # Internal IT CPU nodepool configuration
  internal_cpu_node_pool_name        = var.cluster_internal_cpu_node_pool_name
  internal_cpu_node_min_count        = var.cluster_internal_cpu_node_min_count
  internal_cpu_node_max_count        = var.cluster_internal_cpu_node_max_count
  internal_cpu_node_type             = var.cluster_internal_cpu_node_type
  internal_cpu_node_disk_size_gb     = var.cluster_internal_cpu_node_disk_size_gb
  internal_cpu_node_use_preemptible  = var.cluster_internal_cpu_node_use_preemptible
  internal_cpu_node_tags             = var.cluster_internal_cpu_node_tags
  internal_cpu_node_taints           = var.cluster_internal_cpu_node_taints

  enable_secure_boot            = var.enable_secure_boot
  enable_integrity_monitoring   = var.enable_integrity_monitoring
  enable_private_nodes          = var.enable_private_nodes
  enable_private_endpoint       = var.enable_private_endpoint
  network_subnet_selflink       = var.network_subnet_selflink
  network_private_endpoint_subnet_selflink = var.network_private_endpoint_subnet_selflink

  depends_on                    = [module.iam, module.network, module.kms, google_project_service.main]
}

locals {
  gpu_node_pool_exists = local.gpu_node_min_count > 0
}
/*******************************************************************************
Cluster addons (ip-masq + storage class)
*******************************************************************************/
module "cluster_addons" {
  source = "./modules/cluster_addons"
  count = (var.cluster_create && var.cluster_addons_create) ? 1 : 0
  kms_crypto_key_id = local.kms_crypto_key_id
  node_zones = local.node_zones
  non_masquerade_cidrs = var.non_masquerade_cidrs
  depends_on = [module.cluster]
}
/*******************************************************************************
  Cluster storage
*******************************************************************************/
/*
module "cluster_storage" {
  source   = "./modules/cluster_storage"
  vpc_name = var.network_vpc_name_selflink
  depends_on = [ 
    module.cluster,
    data.google_client_config.main
  ] 
}
*/

/*******************************************************************************
  Cert Manager
*******************************************************************************/


module "cert_manager" {
  count      = var.cert_manager_create ? 1 : 0
  source     = "./modules/cert_manager"
  name     = "${local.name}-cm"
  cert_manager_acme_email = var.cert_manager_acme_email
  project_id = var.project_id
  namespace  = "cert-manager"

  depends_on = [
    module.cluster,
    module.iam
  ]
}

/*******************************************************************************
  Helm Releases
*******************************************************************************/


data "kubernetes_nodes" "gpu_nodes" {
  count                        = var.gpu_operator_chart_install && !var.cluster_autopilot ? 1 : 0
  metadata {
    labels = {
      "instance_type" = "worker-gpu"
    }
  }
  depends_on = [module.cluster]
}


module "gpu_operator" {
  source                       = "./modules/gpu_operator"
  count                        = var.gpu_operator_chart_install && !var.cluster_autopilot ? 1 : 0
  cluster_name                 = module.cluster.0.cluster_name
  cloud_provider_name          = "gcp"
  gpu_node_pool_is_ready       = local.gpu_node_pool_exists
  gpu_node_pool_id             = module.cluster.0.gpu_node_pool_id
  gpu_operator_chart_version   = var.gpu_operator_chart_version
  gpu_operator_driver_version  = var.gpu_operator_driver_version
  gpu_operator_toolkit_version = var.gpu_operator_toolkit_version
  gpu_operator_namespace       = var.gpu_operator_namespace
  depends_on                   = [module.cluster, data.kubernetes_nodes.gpu_nodes]
}

