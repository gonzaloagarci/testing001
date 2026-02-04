output "instance_connection_name" {
  description = "Instance Connection Name"
  value       = google_sql_database_instance.main.connection_name
}

output "instance_private_ip_address" {
  description = "Instance Private IP Address"
  value       = google_sql_database_instance.main.private_ip_address
}

output "instance_username" {
  description = "Instance Username"
  value       = google_sql_user.main.name
  sensitive   = true
}

output "instance_password" {
  description = "Instance Password"
  value       = google_sql_user.main.password
  sensitive   = true
}

output "database_name" {
  description = "Database Name"
  value       = google_sql_database.main.name
}
