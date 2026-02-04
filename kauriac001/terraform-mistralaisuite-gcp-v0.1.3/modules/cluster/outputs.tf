output "cluster_name" {
  description = "Cluster Name"
  value       = google_container_cluster.main.name
}

output "cluster_id" {
  description = "Cluster Id"
  value       = google_container_cluster.main.id
}

output "cluster_endpoint" {
  description = "Cluster Endpoint"
  value       = google_container_cluster.main.endpoint
}

output "dns_endpoint" {
  description = "Cluster Endpoint"
  value       = google_container_cluster.main.control_plane_endpoints_config[0].dns_endpoint_config[0].endpoint
}

output "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  sensitive   = true
  value = base64decode(
    google_container_cluster.main.master_auth.0.cluster_ca_certificate
  )
}

output "cluster_get_creds_cmd" {
  description = "Command to get cluster credentials"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.main.name} --region ${var.region} --project ${var.project_id}"
}

# Comentamos los dos outputs referentes al node pool separado ya que no se crea
/*
output "cpu_node_pool_name" {
  description = "CPU Node Pool Name"
  value       = var.autopilot ? null : google_container_node_pool.cpu_nodes.0.name
}

output "cpu_node_pool_id" {
  description = "CPU Node Pool ID"
  value       = var.autopilot ? null : google_container_node_pool.cpu_nodes.0.id
}
*/

/*
output "cpu_node_pool_name" {
  description = "CPU Node Pool Name"
  # Accedemos al primer (y único) node_pool definido dentro del recurso del clúster
  value       = var.autopilot ? null : google_container_cluster.main.node_pool[0].name
}

output "cpu_node_pool_id" {
  description = "CPU Node Pool ID. NOTA: Al estar definido dentro del clúster, se expone el nombre como identificador principal."
  # El atributo 'id' completo no se expone aquí, pero el nombre es el identificador que necesitas.
  value       = var.autopilot ? null : google_container_cluster.main.node_pool[0].name
}
*/

output "cpu_node_pool_name" {
  description = "CPU Node Pool Name"
  value       = var.autopilot || var.cpu_node_min_count == 0 ? null : google_container_node_pool.cpu_nodes.0.name
}

output "cpu_node_pool_id" {
  description = "CPU Node Pool ID."
  value       = var.autopilot || var.cpu_node_min_count == 0 ? null : google_container_node_pool.cpu_nodes.0.name
}

output "gpu_node_pool_name" {
  description = "GPU Node Pool Name"
  value       = var.gpu_node_min_count == 0 && var.gpu_node_max_count == 0 ? null : google_container_node_pool.gpu_nodes.0.name
}

output "gpu_node_pool_id" {
  description = "GPU Node Pool ID"
  value       = var.gpu_node_min_count == 0 && var.gpu_node_max_count == 0 ? "autopilot" : google_container_node_pool.gpu_nodes.0.id
  precondition {
    condition     = var.gpu_node_min_count == 0 && var.gpu_node_max_count == 0 ? true : length(google_container_node_pool.gpu_nodes.0.instance_group_urls) > 0
    error_message = "GPU Node Pool status not available"
  }
}

output "internal_cpu_node_pool_name" {
  description = "Internal IT CPU Node Pool Name"
  value       = var.autopilot || var.internal_cpu_node_min_count == 0 ? null : google_container_node_pool.internal_cpu_nodes.0.name
}

output "internal_cpu_node_pool_id" {
  description = "Internal IT CPU Node Pool ID"
  value       = var.autopilot || var.internal_cpu_node_min_count == 0 ? null : google_container_node_pool.internal_cpu_nodes.0.id
}


output "dbg_enable_private_endpoint" { 
  value = var.enable_private_endpoint 
}
