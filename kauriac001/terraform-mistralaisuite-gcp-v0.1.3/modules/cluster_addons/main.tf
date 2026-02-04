resource "kubernetes_storage_class_v1" "mai_suite_rwo" {
    metadata {
            name = "mai-suite-rwo"
        }
            storage_provisioner = "pd.csi.storage.gke.io"
        parameters = {
            type = "pd-balanced"
            disk-encryption-kms-key = var.kms_crypto_key_id
            replication-type = "regional-pd"
        }
    reclaim_policy = "Delete"
    allow_volume_expansion = true
    volume_binding_mode = "WaitForFirstConsumer"
    allowed_topologies {
        match_label_expressions {
            key = "topology.gke.io/zone"
            values = var.node_zones
            }
    }
}
#####################################################################
# ConfigMap Ip Masquerading Mistral AI Suite
#####################################################################
resource "kubernetes_config_map_v1" "ip_masq_agent_config" {
    metadata {
        name = "ip-masq-agent"
        namespace = "kube-system"
    }
    data = {
        "config" = yamlencode({
        # Destinations that not be masqueraded
        nonMasqueradeCIDRs = var.non_masquerade_cidrs
        masqueradeAll = false
        })
    }
}