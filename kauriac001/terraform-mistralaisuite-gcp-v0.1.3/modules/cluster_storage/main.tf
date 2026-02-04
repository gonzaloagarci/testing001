/*******************************************************************************
  StorageClass for filestore
*******************************************************************************/

resource "kubernetes_storage_class_v1" "filestore_rwx" {
  metadata {
    name = "mai-suite-rwx"
  }

  storage_provisioner = "filestore.csi.storage.gke.io"

  parameters = {
    tier    = "STANDARD"
    connect-mode= "PRIVATE_SERVICE_ACCESS"
    network = var.vpc_name  
    # reserved-ip-range = ""       
  }

  reclaim_policy         = "Delete"
  allow_volume_expansion = true
  volume_binding_mode    = "Immediate" # "WaitForFirstConsumer" not required as the zone is already set by the network

}