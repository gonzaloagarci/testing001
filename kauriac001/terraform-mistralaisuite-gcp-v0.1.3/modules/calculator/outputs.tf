output "cpu_node_count" {
  description = "CPU Node Count"
  value       = local.result.cpu_node_count
}

output "total_cpu_requests" {
  value = local.result.total_cpu_requests
}

output "cpu_per_gpu_node" {
  value = local.result.cpu_per_gpu_node
}

output "gpu_node_count" {
  description = "GPU Node Count"
  value       = local.result.gpu_node_count
}

output "total_gpu_requests" {
  value = local.result.total_gpu_requests
}

output "gpu_per_gpu_node" {
  value = local.result.gpu_per_gpu_node
}

output "node_zones" {
  description = "Node Zones"
  value       = local.result.node_zones
}
