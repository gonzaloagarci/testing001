# Data source to reference existing subnet
data "google_compute_subnetwork" "existing" {
  name    = var.subnet_name
  region  = var.region
  project = var.host_project_id
}

# Static internal IP address for the load balancer
resource "google_compute_address" "loadbalancer" {
  name         = var.load_balancer_ip_name
  project      = var.project_id
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = data.google_compute_subnetwork.existing.self_link
  purpose      = "GCE_ENDPOINT"
  address      = var.load_balancer_ip_address
}