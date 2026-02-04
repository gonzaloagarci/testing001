locals {
  # Use created service account email or provided existing email
  service_account_email = var.create_service_account ? google_service_account.main[0].email : var.service_account_email
}

resource "google_service_account" "main" {
  count        = var.create_service_account ? 1 : 0
  account_id   = var.name
  display_name = var.name
  description  = var.description
}

resource "google_project_iam_member" "storage_admin" {
  count   = var.create_service_account ? 1 : 0
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.main[0].email}"
}

resource "google_project_iam_member" "default_node_service_account" {
  count   = var.create_service_account ? 1 : 0
  project = var.project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${google_service_account.main[0].email}"
}

resource "google_service_account_key" "main" {
  count              = var.create_service_account ? 1 : 0
  service_account_id = google_service_account.main[0].name
  public_key_type    = "TYPE_X509_PEM_FILE"
  depends_on         = [google_service_account.main]
}

# Workload Identity Bindings
resource "google_service_account_iam_member" "workload_identity_bindings" {
  for_each = {
    for binding in var.workload_identity_bindings :
    "${binding.namespace}/${binding.k8s_sa_name}" => binding
  }

  #service_account_id = local.service_account_email
  service_account_id = "projects/${var.project_id}/serviceAccounts/${local.service_account_email}"

  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.value.namespace}/${each.value.k8s_sa_name}]"
}
