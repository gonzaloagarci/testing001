output "iam_service_account_email" {
  description = "IAM Service Account Email"
  value       = var.iam_create ? module.iam.0.service_account_email : null
}

output "iam_service_account_name" {
  description = "IAM Service Account Name"
  value       = var.iam_create ? module.iam.0.service_account_name : null
}

output "iam_service_account_id" {
  description = "IAM Service Account ID"
  value       = var.iam_create ? module.iam.0.service_account_id : null
}

output "iam_service_account_creds" {
  description = "IAM Service Account Credentials"
  value       = var.iam_create ? module.iam.0.service_account_creds : null
  sensitive   = true
}

output "network_vpc_id" {
  description = "Network VPC ID"
  value       = var.network_vpc_create ? module.network.0.vpc_id : null
}

output "network_vpc_name" {
  description = "NetworkVPC Name"
  value       = var.network_vpc_create ? module.network.0.vpc_name : null
}

output "network_nat_name" {
  description = "Network NAT Name"
  value       = var.network_vpc_create && var.network_nat_create ? module.network.0.nat_name : null
}

output "network_router_name" {
  description = "Network Router Name"
  value       = var.network_vpc_create && var.network_nat_create ? module.network.0.router_name : null
}

output "network_subnet_id" {
  description = "Subnetwork ID"
  value       = var.network_vpc_create ? module.network.0.subnet_id : null
}

output "network_subnet_name" {
  description = "Subnetwork Name"
  value       = var.network_vpc_create ? module.network.0.subnet_name : null
}

output "network_subnet_ip_cidr_range_nodes" {
  description = "Subnetwork IP CIDR Range for Nodes"
  value       = var.network_vpc_create ? module.network.0.subnet_ip_cidr_range_nodes : null
}

output "network_subnet_ip_cidr_range_pods" {
  description = "Subnetwork IP CIDR Range for Pods"
  value       = var.network_vpc_create ? module.network.0.subnet_ip_cidr_range_pods : null
}

output "network_subnet_ip_cidr_range_services" {
  description = "Subnetwork IP CIDR Range for Services"
  value       = var.network_vpc_create ? module.network.0.subnet_ip_cidr_range_services : null
}

output "kms_crypto_key_id" {
  description = "KMS Crypto Key ID"
  value       = module.kms.crypto_key_id
}

output "cluster_name" {
  description = "Cluster Name"
  value       = var.cluster_create ? module.cluster.0.cluster_name : null
}

output "cluster_id" {
  description = "Cluster Id"
  value       = var.cluster_create ? module.cluster.0.cluster_id : null
}

output "cluster_endpoint" {
  description = "Cluster Endpoint"
  value       = var.cluster_create ? module.cluster.0.cluster_endpoint : null
}

output "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  sensitive   = true
  value       = var.cluster_create ? module.cluster.0.cluster_ca_certificate : null
}

output "cluster_get_creds_cmd" {
  description = "Command to get cluster credentials"
  value       = var.cluster_create ? "gcloud container clusters get-credentials ${module.cluster.0.cluster_name} --region ${var.region} --project ${var.project_id}" : null
}

output "cluster_cpu_node_pool_name" {
  description = "Cluster CPU Node Pool Name"
  value       = var.cluster_create ? module.cluster.0.cpu_node_pool_name : null
}

output "cluster_cpu_node_pool_id" {
  description = "Cluster CPU Node Pool ID"
  value       = var.cluster_create ? module.cluster.0.cpu_node_pool_id : null
}

output "cluster_gpu_node_pool_name" {
  description = "Cluster GPU Node Pool Name"
  value       = var.cluster_create ? module.cluster.0.gpu_node_pool_name : null
}

output "cluster_gpu_node_pool_id" {
  description = "Cluster GPU Node Pool ID"
  value       = var.cluster_create ? module.cluster.0.gpu_node_pool_id : null
}

output "storage_bucket_models_name" {
  description = "Storage Bucket Models Name"
  value       = module.buckets.models_name
}

output "storage_bucket_models_url" {
  description = "Storage Bucket Models URL"
  value       = module.buckets.models_url
}

output "storage_bucket_models_location" {
  description = "Storage Bucket Models Location"
  value       = module.buckets.models_location
}

output "storage_bucket_apps_name" {
  description = "Storage Bucket Apps Name"
  value       = module.buckets.apps_name
}

output "storage_bucket_apps_url" {
  description = "Storage Bucket Apps URL"
  value       = module.buckets.apps_url
}

output "storage_bucket_apps_location" {
  description = "Storage Bucket Apps Location"
  value       = module.buckets.apps_location
}

output "storage_bucket_backups_name" {
  description = "Storage Bucket Backups Name"
  value       = module.buckets.backups_name
}

output "storage_bucket_backups_url" {
  description = "Storage Bucket Backups URL"
  value       = module.buckets.backups_url
}

output "storage_bucket_backups_location" {
  description = "Storage Bucket Backups Location"
  value       = module.buckets.backups_location
}

output "nfs_instance_name" {
  description = "NFS Instance Name"
  value       = var.nfs_create ? module.nfs.0.instance_name : null
}

output "nfs_instance_ip_address" {
  description = "NFS Instance IP Address"
  value       = var.nfs_create ? module.nfs.0.instance_ip_address : null
}

output "managed_database_instance_connection_name" {
  description = "Managed Database Instance Connection Name"
  value       = var.managed_database_create ? module.managed_database.0.instance_connection_name : null
}

output "managed_database_instance_private_ip_address" {
  description = "Managed Database Instance Private IP Address"
  value       = var.managed_database_create ? module.managed_database.0.instance_private_ip_address : null
}

output "managed_database_instance_username" {
  description = "Managed Database Instance Username"
  value       = var.managed_database_create ? module.managed_database.0.instance_username : null
  sensitive   = true
}

output "managed_database_instance_password" {
  description = "Managed Database Instance Password"
  value       = var.managed_database_create ? module.managed_database.0.instance_password : null
  sensitive   = true
}

output "managed_database_name" {
  description = "Managed Database Name"
  value       = var.managed_database_create ? module.managed_database.0.database_name : null
}

# output "access_token" {
#   value       = data.google_service_account_access_token.main.access_token
#   description = "El token de acceso de Google Cloud."
#   sensitive   = true
# }

# output "access_token" {
#   value = data.google_client_config.main.access_token
#   description = "El token de acceso de Google Cloud."
#   sensitive = false
# }
