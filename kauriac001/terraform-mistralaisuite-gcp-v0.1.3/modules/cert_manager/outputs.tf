output "cert_manager_sa_email" {
  description = "cert-manager email address"
  value       = google_service_account.cert_manager.email
}

output "cert_manager_namespace" {
  description = "cert-manager namespace"
  value       = kubernetes_namespace.cert_manager.metadata[0].name
}