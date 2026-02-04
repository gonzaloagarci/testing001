data "google_compute_subnetwork" "nodessubnetwork" {
  name    = var.network_subnet_name
  region  = var.region
  project = var.host_project_id
}

data "google_compute_subnetwork" "vipsubnetwork" {
  name    = var.network_lb_subnet_name
  region  = var.region
  project = var.host_project_id
}

/*
data "google_compute_subnetwork" "podssubnetwork" {
  name    = var.network_pods_subnet_name
  region  = var.region
  project = var.host_project_id
}
*/

module "mistral" {
  source                                     = "../terraform-mistralaisuite-gcp-v0.1.3"
  project_id                                 = var.project_id
  host_project_id                            = var.host_project_id
  region                                     = var.region
  network_vpc_create                         = var.network_vpc_create
  network_vpc_name                           = var.network_vpc_name
  network_subnet_name                        = var.network_subnet_name
  network_pods_subnet_name                   = var.network_pods_subnet_name
  network_lb_subnet_name                     = var.network_lb_subnet_name
  network_nat_create                         = var.network_nat_create
  network_subnet_ip_cidr_range_nodes         = data.google_compute_subnetwork.nodessubnetwork.ip_cidr_range
  network_subnet_ip_cidr_range_master        = data.google_compute_subnetwork.vipsubnetwork.ip_cidr_range
#  network_subnet_ip_cidr_range_pods          = data.google_compute_subnetwork.podssubnetwork.ip_cidr_range
  network_subnet_ip_cidr_range_pods          = null
  network_subnet_ip_cidr_range_services      = null
  network_vpc_name_selflink                  = var.network_vpc_name_selflink
  network_subnet_selflink                    = var.network_subnet_selflink
  network_private_endpoint_subnet_selflink   = var.network_private_endpoint_subnet_selflink
  kms_create                                 = var.kms_create
  kms_crypto_key_id                          = var.kms_crypto_key_id
  iam_create                                 = var.iam_create
  iam_service_account_email                  = var.iam_service_account_email
  iam_service_account_creds                  = var.iam_service_account_creds
  cluster_create                             = var.cluster_create
  cluster_release_channel                    = var.cluster_release_channel
  cluster_autopilot                          = var.cluster_autopilot
  cluster_node_zones                         = var.cluster_node_zones
  cluster_kubernetes_version                 = var.cluster_kubernetes_version
  cluster_kubernetes_general_node_version    = var.cluster_kubernetes_general_node_version
  cluster_kubernetes_internal_node_version   = var.cluster_kubernetes_internal_node_version  
  cluster_node_pool_auto_upgrade             = var.cluster_node_pool_auto_upgrade
  cluster_cpu_node_disk_size_gb              = var.cluster_cpu_node_disk_size_gb
  cluster_cpu_node_pool_name                 = var.cluster_cpu_node_pool_name
  initial_node_count_per_zone                = var.initial_node_count_per_zone
  cluster_cpu_node_min_count                 = var.cluster_cpu_node_min_count
  cluster_cpu_node_max_count                 = var.cluster_cpu_node_max_count
  cluster_cpu_node_use_preemptible           = var.cluster_cpu_node_use_preemptible
  cluster_cpu_node_type                      = var.cluster_cpu_node_type
  cluster_cpu_node_tags                      = var.cluster_cpu_node_tags
  cluster_resource_manager_tags              = var.cluster_resource_manager_tags
  cluster_gpu_reservation_name               = var.cluster_gpu_reservation_name
  cluster_gpu_node_min_count                 = var.cluster_gpu_node_min_count
  cluster_gpu_node_max_count                 = var.cluster_gpu_node_max_count
  cluster_gpu_node_gpu_type                  = var.cluster_gpu_node_gpu_type
  cluster_gpu_node_gpu_count                 = var.cluster_gpu_node_gpu_count
  cluster_gpu_node_use_preemptible           = var.cluster_gpu_node_use_preemptible
  cluster_gpu_node_type                      = var.cluster_gpu_node_type
  cluster_gpu_node_disk_size_gb              = var.cluster_gpu_node_disk_size_gb
  cluster_gpu_node_local_ssd_count           = var.cluster_gpu_node_local_ssd_count
  cluster_gpu_node_tags                      = var.cluster_gpu_node_tags
  cluster_gpu_driver_version 						     = var.cluster_gpu_driver_version
  cluster_internal_cpu_node_pool_name        = var.cluster_internal_cpu_node_pool_name
  cluster_internal_cpu_node_min_count        = var.cluster_internal_cpu_node_min_count
  cluster_internal_cpu_node_max_count        = var.cluster_internal_cpu_node_max_count
  cluster_internal_cpu_node_type             = var.cluster_internal_cpu_node_type
  cluster_internal_cpu_node_disk_size_gb     = var.cluster_internal_cpu_node_disk_size_gb
  cluster_internal_cpu_node_use_preemptible  = var.cluster_internal_cpu_node_use_preemptible
  cluster_internal_cpu_node_tags             = var.cluster_internal_cpu_node_tags
  cluster_internal_cpu_node_taints           = var.cluster_internal_cpu_node_taints
  bucket_models_create 									     = var.bucket_models_create
  bucket_apps_create 										     = var.bucket_apps_create
  bucket_backups_create 								     = var.bucket_backups_create
  bucket_storage_class 									     = var.bucket_storage_class
  bucket_force_destroy 									     = var.bucket_force_destroy
  bucket_versioning_enabled 						     = var.bucket_versioning_enabled
  bucket_uniform_level_access                = var.bucket_uniform_level_access
  nfs_create 														     = var.nfs_create
  nfs_tier 															     = var.nfs_tier
  nfs_protocol 													     = var.nfs_protocol
  nfs_capacity_gb 											     = var.nfs_capacity_gb
  managed_database_create 							     = var.managed_database_create
  gpu_operator_chart_install 						     = var.gpu_operator_chart_install
  gpu_operator_chart_version 						     = var.gpu_operator_chart_version
  gpu_operator_driver_version 					     = var.gpu_operator_driver_version
  gpu_operator_namespace 								     = var.gpu_operator_namespace
  gpu_operator_toolkit_version 					     = var.gpu_operator_toolkit_version
  
  apisix_load_balancer_ip_name               = var.apisix_load_balancer_ip_name
  apisix_load_balancer_ip_address            = var.apisix_load_balancer_ip_address

  enable_secure_boot                         = var.enable_secure_boot
  enable_integrity_monitoring                = var.enable_integrity_monitoring
  enable_private_nodes                       = var.enable_private_nodes
  enable_private_endpoint                    = var.enable_private_endpoint

  workload_identity_bindings                 = var.workload_identity_bindings

  providers = {
    google = google
  }
}


#Create GKE Backup Plan definitions


# --- PLAN 1: DISASTER RECOVERY (Diary, Full + Volums) ---
resource "google_gke_backup_backup_plan" "dr_daily" {
  name     = "${module.mistral.cluster_name}-backup-dr-daily"
  cluster  = module.mistral.cluster_id

  location = var.region # Misma región que el control plane

  retention_policy {
    backup_delete_lock_days = 0  # Seguridad: Nadie puede borrarlo en 5 días
    backup_retain_days      = 30 # Retención de 1 mes
  }

  backup_schedule {
    cron_schedule = "0 3 * * *" # 03:00 AM todos los días
  }

  backup_config {
    include_volume_data = true # CRÍTICO: Esto hace el snapshot del disco de Postgres
    include_secrets     = true # Necesario para recuperar las contraseñas/certs
    all_namespaces      = true # Backup de todo el clúster

    encryption_key {
      gcp_kms_encryption_key = module.mistral.kms_crypto_key_id
    }
  }

  # Esperar a que el cluster esté listo
  depends_on = [ module.mistral ]
}

# --- PLAN 2: OPERACIONAL (Frecuente, Solo Configuración) ---
# Útil para reversiones rápidas de deployments sin esperar snapshots de disco

resource "google_gke_backup_backup_plan" "ops_fast" {
  name     = "${module.mistral.cluster_name}-backup-ops-config"
  cluster  = module.mistral.cluster_id

  location = var.region

  retention_policy {
    backup_delete_lock_days = 0 # Sin bloqueo, para poder limpiar si es necesario
    backup_retain_days      = 7 # Solo nos interesa la última semana
  }

  backup_schedule {
    cron_schedule = "0 */6 * * *" # Cada 6 horas
  }

  backup_config {
    include_volume_data = false # Ahorra costes y tiempo. NO guarda datos de BD.
    include_secrets     = true
    all_namespaces      = true 

    encryption_key {
      gcp_kms_encryption_key = module.mistral.kms_crypto_key_id
    }
  }

  depends_on = [ module.mistral ]
}

# --- Canal de Notificación (Email) ---
resource "google_monitoring_notification_channel" "backup_email" {
  display_name = "GKE Backup Alerts - ${module.mistral.cluster_name}"
  type         = "email"
  project      = var.project_id
  
  labels = {
    email_address = var.alert_notification_email
  }
}

# --- Política de Alerta: Fallo en Backup ---
resource "google_monitoring_alert_policy" "backup_failed" {
  display_name = "CRITICAL: GKE Backup Failed - ${module.mistral.cluster_name}"
  combiner     = "OR"
  project      = var.project_id
  enabled      = true

  conditions {
      display_name = "Backup Run Failed Log Pattern"
      
      condition_matched_log {
        # Aquí traducimos tu MQL a un filtro de Logs
        # Nota: He corregido el "!=" por "=" para detectar fallos
        filter = <<EOT
          logName="projects/${var.project_id}/logs/gkebackup.googleapis.com%2Fbackup_change" AND
          resource.type="gkebackup.googleapis.com/BackupPlan" AND
          resource.labels.location="europe-southwest1" AND
          jsonPayload.changeType="UPDATE" AND
          jsonPayload.inputBackup.state="FAILED"
        EOT
      }
  }

  notification_channels = [google_monitoring_notification_channel.backup_email.name]
  
  # Cierra la incidencia automáticamente si dejan de llegar errores tras 7 días
  alert_strategy {
    auto_close = "604800s" 
    notification_rate_limit {
      period = "300s" # Para no recibir spam si el log se repite mucho en 5 min
    }
  }

  documentation {
    mime_type = "text/markdown"
    content   = <<EOT
    # Fallo en el Backup de GKE
    
    El plan de backup en el clúster **${module.mistral.cluster_name}** (${var.project_id}) ha reportado un fallo.
    
    ### Acciones Inmediatas:
    1. Ve a la consola de [Backup for GKE](https://console.cloud.google.com/kubernetes/backup/backups?project=${var.project_id}).
    2. Identifica si el fallo es en el plan DR (Diario) o en el Operacional.
    3. Revisa los logs. Causas comunes:
       - La clave KMS ha sido deshabilitada o revocada.
       - La Service Account del agente de backup perdió permisos.
       - (Si aplica) El script de consistencia de BD falló.
    
    EOT
  }
  
  # Asegura que se crea después de los planes para evitar condiciones de carrera en la API
  depends_on = [
    google_gke_backup_backup_plan.dr_daily,
    google_gke_backup_backup_plan.ops_fast
  ]
}
