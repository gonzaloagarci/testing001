output "ip_address" {
  description = "The allocated internal IP address"
  value       = google_compute_address.loadbalancer.address
}

output "ip_name" {
  description = "The name of the IP address resource"
  value       = google_compute_address.loadbalancer.name
}

output "ip_self_link" {
  description = "The self link of the IP address resource"
  value       = google_compute_address.loadbalancer.self_link
}

output "subnet_cidr" {
  description = "CIDR range of the subnet where IP is allocated"
  value       = data.google_compute_subnetwork.existing.ip_cidr_range
}