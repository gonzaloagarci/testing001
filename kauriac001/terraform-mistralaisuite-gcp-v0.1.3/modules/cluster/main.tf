data "google_project" "main" {
  project_id = var.project_id
}

data "google_container_engine_versions" "latest" {
  location = var.region
  project  = var.project_id
}

locals {
  # Defino esto aquí una sola vez. No hace falta tocar variables.tf
  # Terraform detecta automáticamente que es una lista de strings.
  node_scopes = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}

/*******************************************************************************
  Sufijo Aleatorio para General CPU Nodes
  Se regenera solo si cambia la configuración inmutable
*******************************************************************************/
resource "random_id" "general_cpu_nodes_suffix" {
  byte_length = 4

  keepers = {
    machine_type    = var.cpu_node_type
    disk_size_gb    = var.cpu_node_disk_size_gb
    image_type      = "UBUNTU_CONTAINERD"
    preemptible     = tostring(var.cpu_node_use_preemptible)
    scopes 			    = join(",", local.node_scopes)
  }
}

/*******************************************************************************
  Sufijo Aleatorio para Internal CPU Nodes
*******************************************************************************/
resource "random_id" "internal_cpu_nodes_suffix" {
  byte_length = 4

  keepers = {
    machine_type    = var.internal_cpu_node_type
    disk_size_gb    = var.internal_cpu_node_disk_size_gb
    image_type      = "UBUNTU_CONTAINERD"
    preemptible     = tostring(var.internal_cpu_node_use_preemptible)
    scopes 			    = join(",", local.node_scopes)   
    # IMPORTANTE: Si cambias los Taints, queremos generar un nuevo pool
    # para asegurar que se limpian correctamente.
    #taints          = jsonencode(var.internal_cpu_node_taints)
  }
}


/*******************************************************************************
  Cluster with default Node Pool
*******************************************************************************/


data "google_compute_subnetwork" "main" {
  name    = var.subnet_name
  region  = var.region
  project = var.host_project_id
}

/*
data "google_compute_network" "xxtintshvpc" {
  name = var.vpc_name
  project = var.host_project_id
}
*/


  resource "google_container_cluster" "main" {
    # --- Configuración General del Clúster ---
    location                    = var.region # Para el control plane, es mejor usar la región
    name                        = var.name
    enable_autopilot            = var.autopilot ? true : null
    deletion_protection         = var.deletion_protection
    enable_intranode_visibility = !var.autopilot ? true : null

    # --- Default Node Pool Configuration ---
    remove_default_node_pool = true
    initial_node_count       = 1

    release_channel {
      channel = var.cluster_release_channel
    }

    node_config {
      boot_disk_kms_key = var.kms_crypto_key_id
      shielded_instance_config {
        enable_secure_boot          = var.enable_secure_boot
        enable_integrity_monitoring = var.enable_integrity_monitoring
      }
      tags = var.cluster_cpu_node_tags
    }

    # --- Configuracion de control plane ---
    control_plane_endpoints_config {
      ip_endpoints_config {
        enabled = true
      }
      dns_endpoint_config {
        allow_external_traffic = true
      }
    }

    # --- Configuración de Red ---
    network    = var.network_vpc_name_selflink
    subnetwork = var.network_subnet_selflink
    ip_allocation_policy {
      #     cluster_secondary_range_name = "projects/gc-pr-xxt-7434-internal-sh-vpc/regions/europe-southwest1/subnetworks/gc-sh-vpc-sb-xxt-internal-base-spoke-449252362511-eu-sw1-3"
      cluster_secondary_range_name = var.network_pods_subnet_name
      #     cluster_secondary_range_name = "gc-sh-vpc-sb-xxt-internal-base-spoke-449252362511-eu-sw1-1"
      #    cluster_ipv4_cidr_block  = try(data.google_compute_subnetwork.main.secondary_ip_range.0.ip_cidr_range, var.subnet_ip_cidr_range_pods)
      #    services_ipv4_cidr_block = try(data.google_compute_subnetwork.main.secondary_ip_range.1.ip_cidr_range, var.subnet_ip_cidr_range_services)
    }

    master_authorized_networks_config {}

    private_cluster_config {
      enable_private_nodes    = var.enable_private_nodes
      enable_private_endpoint = var.enable_private_endpoint
      # master_ipv4_cidr_block  = var.network_subnet_ip_cidr_range_master
      private_endpoint_subnetwork = var.network_private_endpoint_subnet_selflink

    }

    # --- Configuración de Versión y Addons ---
    min_master_version = var.kubernetes_version
    addons_config {
      gcp_filestore_csi_driver_config {
        enabled = true
      }
      gke_backup_agent_config {
        enabled = true
      }
    }

    # --- Cifrado y Seguridad ---
    workload_identity_config {
      workload_pool = "${data.google_project.main.project_id}.svc.id.goog"
    }
    database_encryption {
      state    = "ENCRYPTED"
      key_name = var.kms_crypto_key_id
    }

    # --- Política de Red y Datapath ---
    # Enable Dataplane V2: https://github.com/hashicorp/terraform-provider-google/issues/13815
    dynamic "network_policy" {
      for_each = var.autopilot ? [] : [1]
      content {
        enabled  = false
        provider = "PROVIDER_UNSPECIFIED"
      }
    }
    datapath_provider = var.autopilot ? null : "ADVANCED_DATAPATH"

    maintenance_policy {
      recurring_window {
        start_time = "2024-11-29T00:00:00Z"
        end_time   = "2024-11-29T06:00:00Z"
        recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
      }
    }

    lifecycle {
      ignore_changes = [
        network,
        subnetwork,
        ip_allocation_policy[0].cluster_secondary_range_name,
        ip_allocation_policy[0].services_secondary_range_name,
        node_config,
        initial_node_count
      ]
    }
  }



/*******************************************************************************
  CPU Node Pool
*******************************************************************************/

resource "google_container_node_pool" "cpu_nodes" {
  count          = var.autopilot ? 0 : 1
  #name           = var.cpu_node_pool_name
  name           = "${var.cpu_node_pool_name}-${random_id.general_cpu_nodes_suffix.hex}"
  location       = length(var.node_zones) == 1 ? one(var.node_zones) : var.region
  node_locations = length(var.node_zones) > 1 ? var.node_zones : null
  cluster        = google_container_cluster.main.name
  version        = var.cluster_kubernetes_general_node_version

  initial_node_count = var.initial_node_count_per_zone

  autoscaling {
    total_min_node_count = var.cpu_node_min_count
    total_max_node_count = var.cpu_node_max_count
    location_policy      = "BALANCED"
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  upgrade_settings {
    strategy = "BLUE_GREEN"

    blue_green_settings {
      # Tiempo para verificar que el nuevo pool (Green) funciona antes de drenar el viejo
      node_pool_soak_duration = "300s" 

      standard_rollout_policy {
        # Mueve los nodos en lotes (puedes usar porcentaje o número fijo)
        batch_node_count    = 1
        
        # Tiempo de espera entre cada lote drenado
        batch_soak_duration = "120s"
      }
    }
  }

  
  node_config {
    image_type = "UBUNTU_CONTAINERD"
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/logging.write",
#      "https://www.googleapis.com/auth/monitoring",
#      "https://www.googleapis.com/auth/devstorage.read_only",
#      "https://www.googleapis.com/auth/compute"
#    ]
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/cloud-platform"
#    ]
    oauth_scopes      = local.node_scopes

    boot_disk_kms_key = var.kms_crypto_key_id
    service_account   = var.service_account_email
    preemptible       = var.cpu_node_use_preemptible
    machine_type      = var.cpu_node_type
    disk_size_gb      = var.cpu_node_disk_size_gb
    tags              = concat(["tf-managed", google_container_cluster.main.name], var.cluster_cpu_node_tags)
    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      part_of    = google_container_cluster.main.name
      env        = var.project_id
      managed_by = "terraform"
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    shielded_instance_config {
      enable_secure_boot          = var.enable_secure_boot
      enable_integrity_monitoring = var.enable_integrity_monitoring
    }
  }
  timeouts {
    create = "35m"
    update = "20m"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [initial_node_count]
  }
  depends_on = [google_container_cluster.main]
}


/*******************************************************************************
  GPU Node Pool
*******************************************************************************/

resource "google_container_node_pool" "gpu_nodes" {
  //  count          = var.autopilot && var.gpu_node_min_count == 0 && var.gpu_node_max_count == 0 ? 0 : 1
  count          = var.gpu_node_min_count == 0 && var.gpu_node_max_count == 0 ? 0 : 1
  name           = var.gpu_node_pool_name
  project        = var.project_id
  location       = length(var.node_zones) == 1 ? one(var.node_zones) : var.region
  node_locations = length(var.node_zones) > 1 ? var.node_zones : null
  cluster        = google_container_cluster.main.name
  autoscaling {
    total_min_node_count = var.gpu_node_min_count
    total_max_node_count = var.gpu_node_max_count
    location_policy      = "BALANCED"
  }
  management {
    auto_repair  = true
    auto_upgrade = var.node_pool_auto_upgrade
  }
  node_config {
    image_type = "UBUNTU_CONTAINERD"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
    ]
    ephemeral_storage_local_ssd_config {
      local_ssd_count = var.gpu_node_local_ssd_count
    }
    guest_accelerator {
      type  = var.gpu_node_gpu_type
      count = var.gpu_node_gpu_count
      gpu_driver_installation_config {
        gpu_driver_version = var.gpu_driver_version
      }
    }
    boot_disk_kms_key = var.kms_crypto_key_id
    service_account   = var.service_account_email
    preemptible       = var.gpu_node_use_preemptible
    machine_type      = var.gpu_node_type
    disk_size_gb      = var.gpu_node_disk_size_gb
    tags              = concat(["tf-managed", google_container_cluster.main.name], var.gpu_node_tags)
    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      part_of                                 = google_container_cluster.main.name
      gke-no-default-nvidia-gpu-device-plugin = "true"
      env                                     = var.project_id
      managed_by                              = "terraform"
    }
    dynamic "reservation_affinity" {
      for_each = var.gpu_reservation_name != "" ? [1] : []
      content {
        consume_reservation_type = "SPECIFIC_RESERVATION"
        key                      = "compute.googleapis.com/reservation-name"
        values                   = ["${var.gpu_reservation_name}"]
      }
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    shielded_instance_config {
      enable_secure_boot          = var.enable_secure_boot
      enable_integrity_monitoring = var.enable_integrity_monitoring
    }
  }
  timeouts {
    create = "30m"
    update = "20m"
  }
  depends_on = [google_container_cluster.main]
}

/*******************************************************************************
  Internal IT CPU Node Pool (with taints for whitelisting)
*******************************************************************************/

resource "google_container_node_pool" "internal_cpu_nodes" {
  count          = var.autopilot || var.internal_cpu_node_min_count == 0 ? 0 : 1
  #name           = var.internal_cpu_node_pool_name
  name           = "${var.internal_cpu_node_pool_name}-${random_id.internal_cpu_nodes_suffix.hex}"
  project        = var.project_id
  location       = length(var.node_zones) == 1 ? one(var.node_zones) : var.region
  node_locations = length(var.node_zones) > 1 ? var.node_zones : null
  cluster        = google_container_cluster.main.name
  version        = var.cluster_kubernetes_internal_node_version

  initial_node_count = var.initial_node_count_per_zone

  autoscaling {
    total_min_node_count = var.internal_cpu_node_min_count
    total_max_node_count = var.internal_cpu_node_max_count
    location_policy      = "BALANCED"
  }

  management {
    auto_repair  = true
    auto_upgrade = false
  }

  upgrade_settings {
    strategy = "BLUE_GREEN"

    blue_green_settings {
      # Tiempo para verificar que el nuevo pool (Green) funciona antes de drenar el viejo
      node_pool_soak_duration = "300s" 

      standard_rollout_policy {
        # Mueve los nodos en lotes (puedes usar porcentaje o número fijo)
        batch_node_count    = 1
        
        # Tiempo de espera entre cada lote drenado
        batch_soak_duration = "120s"
      }
    }
  }

  node_config {
    image_type = "UBUNTU_CONTAINERD"
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/logging.write",
#      "https://www.googleapis.com/auth/monitoring",
#      "https://www.googleapis.com/auth/devstorage.read_only",
#      "https://www.googleapis.com/auth/compute"
#    ]
#    oauth_scopes = [
#      "https://www.googleapis.com/auth/cloud-platform"
#    ]
    oauth_scopes      = local.node_scopes

    boot_disk_kms_key = var.kms_crypto_key_id
    service_account   = var.service_account_email
    preemptible       = var.internal_cpu_node_use_preemptible
    machine_type      = var.internal_cpu_node_type
    disk_size_gb      = var.internal_cpu_node_disk_size_gb
    tags              = concat(["tf-managed", google_container_cluster.main.name], var.internal_cpu_node_tags)

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      part_of       = google_container_cluster.main.name
      env           = var.project_id
      managed_by    = "terraform"
      nodepool_type = "internal-it-cpu"
      workload_type = "internal-landscape"
    }

    # Taints for whitelisting internal IT landscape workloads
    dynamic "taint" {
      for_each = var.internal_cpu_node_taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = var.enable_secure_boot
      enable_integrity_monitoring = var.enable_integrity_monitoring
    }
  }

  timeouts {
    create = "35m"
    update = "20m"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [initial_node_count]
  }

  depends_on = [google_container_cluster.main]
}


/*******************************************************************************
  IAM Binding for GKE nodes SA
*******************************************************************************/
/*
resource "google_project_iam_member" "gke_node_sa_default_role" {
  project = var.project_id
  role    = "roles/container.defaultNodeServiceAccount"
  member  = "serviceAccount:${var.service_account_email}"
}
*/

/*
resource "kubernetes_storage_class_v1" "filestore_rwx" {
  metadata {
    name = "mai-suite-rwx"
  }

  storage_provisioner = "filestore.csi.storage.gke.io"

  parameters = {
    tier    = "STANDARD"
    network = var.vpc_name  
    # reserved-ip-range = ""       
  }

  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "Immediate" # "WaitForFirstConsumer" not required as the zone is already set by the network

}
*/