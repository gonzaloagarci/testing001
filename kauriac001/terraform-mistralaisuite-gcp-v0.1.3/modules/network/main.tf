resource "google_project_service" "servicenetworking" {
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc" {
  count                   = var.vpc_create ? 1 : 0
  name                    = var.vpc_name
  auto_create_subnetworks = false
  depends_on              = [google_project_service.servicenetworking]
}

resource "google_compute_subnetwork" "subnet" {
  count                    = var.vpc_create ? 1 : 0
  name                     = var.subnet_name
  region                   = var.region
  network                  = google_compute_network.vpc.0.name
  ip_cidr_range            = var.subnet_ip_cidr_range_nodes
  private_ip_google_access = true
  secondary_ip_range {
    range_name    = "gke-mistral-ai-suite-pods"
    ip_cidr_range = var.subnet_ip_cidr_range_pods
  }
  secondary_ip_range {
    range_name    = "gke-mistral-ai-suite-services"
    ip_cidr_range = var.subnet_ip_cidr_range_services
  }
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

data "google_compute_network" "vpc" {
  count = var.vpc_create ? 0 : 1
  name  = var.vpc_name
}

resource "google_compute_address" "load_balancer" {
  count        = var.load_balancer_ip_create ? 1 : 0
  name         = var.load_balancer_ip_name
  project      = var.project_id
  region       = var.region 
  address_type = "INTERNAL"
}

resource "google_compute_global_address" "peering" {
  name          = var.vpc_peering_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = var.vpc_create ? google_compute_network.vpc.0.self_link : data.google_compute_network.vpc.0.self_link
  depends_on = [
    google_project_service.servicenetworking,
    google_compute_subnetwork.subnet
  ]
}

resource "google_service_networking_connection" "main" {
  network         = var.vpc_create ? google_compute_network.vpc.0.self_link : data.google_compute_network.vpc.0.self_link
  service         = "servicenetworking.googleapis.com"
  deletion_policy = "ABANDON"
  reserved_peering_ranges = [
    google_compute_global_address.peering.name
  ]
  depends_on = [
    google_compute_subnetwork.subnet
  ]
}

# Router for Cloud NAT
resource "google_compute_router" "main" {
  count   = var.vpc_create && var.nat_create ? 1 : 0
  name    = var.router_name
  region  = var.region
  network = google_compute_network.vpc.0.name
  depends_on = [
    google_compute_subnetwork.subnet
  ]
}

# Cloud NAT for egress internet access
resource "google_compute_router_nat" "main" {
  count                              = var.vpc_create && var.nat_create ? 1 : 0
  name                               = var.nat_name
  router                             = google_compute_router.main.0.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  depends_on = [
    google_compute_router.main
  ]
}

# TODO: add firewall rules for the VPC
