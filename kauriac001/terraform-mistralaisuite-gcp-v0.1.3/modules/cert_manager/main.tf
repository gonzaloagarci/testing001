# === GCP Service Account for cert-manager ===
resource "google_service_account" "cert_manager" {
  account_id   = var.name
  display_name = "Cert Manager DNS Solver"
}

resource "google_project_iam_member" "cert_manager_dns_admin" {
  project = var.project_id
  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager.email}"
}

resource "google_service_account_iam_member" "cert_manager_wi" {
  service_account_id = google_service_account.cert_manager.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.namespace}/cert-manager]"
}


resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.namespace
  }
}


resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = var.namespace
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.17.1"

  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

    set {
    name  = "serviceAccount.name"
    value = "cert-manager"
  }

  set {
  name  = "extraArgs[0]"
  value = "--issuer-ambient-credentials=true"
  }

  depends_on = [kubernetes_service_account.cert_manager]

}

resource "kubernetes_service_account" "cert_manager" {
  metadata {
    name      = "cert-manager"
    namespace = var.namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.cert_manager.email
    }
  }

  depends_on = [kubernetes_namespace.cert_manager]
}