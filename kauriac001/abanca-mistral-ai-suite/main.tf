data "google_client_config" "default" {
  provider = google
}

data "google_service_account_access_token" "terraform" {
  provider               = google.principal
  target_service_account = var.terraform_project_email
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "3600s"
}

resource "random_string" "random" {
  length           = var.random_string_length
  special          = var.random_string_special
  override_special = "/@£$"
}

output "seed_project_id" {
  value       = var.seed_project_id
  description = "El valor de la variable seed_project_id"
}
