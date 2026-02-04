output "vpc_id" {
  description = "VPC ID"
  value       = google_compute_network.vpc.0.id
}

output "vpc_name" {
  description = "VPC Name"
  value       = google_compute_network.vpc.0.name
}

output "subnet_id" {
  description = "Subnetwork ID"
  value       = google_compute_subnetwork.subnet.0.id
}

output "subnet_name" {
  description = "Subnetwork Name"
  value       = google_compute_subnetwork.subnet.0.name
}

output "subnet_ip_cidr_range_nodes" {
  description = "Subnetwork IP CIDR Range for Nodes"
  value       = google_compute_subnetwork.subnet.0.ip_cidr_range
}

output "subnet_ip_cidr_range_pods" {
  description = "Subnetwork IP CIDR Range for Pods"
  value       = google_compute_subnetwork.subnet.0.secondary_ip_range.0.ip_cidr_range
}

output "subnet_ip_cidr_range_services" {
  description = "Subnetwork IP CIDR Range for Services"
  value       = google_compute_subnetwork.subnet.0.secondary_ip_range.1.ip_cidr_range
}

output "nat_name" {
  description = "Name of the Cloud NAT gateway"
  value       = var.nat_create ? google_compute_router_nat.main.0.name : null
}

output "router_name" {
  description = "Name of the router for Cloud NAT"
  value       = var.nat_create ? google_compute_router.main.0.name : null
}

output "load_balancer_ip_address" {
  description = "Load Balancer IP Address"
  value       = var.load_balancer_ip_create ? google_compute_address.load_balancer[0].address : null
}
