output "instance_name" {
  description = "Instance Name"
  value       = google_filestore_instance.main.name
}

output "instance_ip_address" {
  description = "Instance IP Address"
  value       = google_filestore_instance.main.networks.0.ip_addresses.0
}

output "instance_file_share_name" {
  description = "Instance File Share Name"
  value       = google_filestore_instance.main.file_shares.0.name
}
