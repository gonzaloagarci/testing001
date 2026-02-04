resource "kubernetes_namespace_v1" "gpu_operator" {
  metadata {
    annotations = {
      name = "gpu-operator"
    }
    labels = {
      cluster    = var.cluster_name
      managed_by = "Terraform"
    }
    name = var.gpu_operator_namespace
  }
  depends_on = [var.gpu_node_pool_is_ready]
}

resource "kubernetes_resource_quota_v1" "gpu_operator_quota" {
  metadata {
    name      = "gpu-operator-quota"
    namespace = kubernetes_namespace_v1.gpu_operator.metadata.0.name
  }
  spec {
    hard = {
      pods = 100
    }
    scope_selector {
      match_expression {
        operator   = "In"
        scope_name = "PriorityClass"
        values     = ["system-node-critical", "system-cluster-critical"]
      }
    }
  }
}

resource "helm_release" "gpu_operator" {
  lifecycle {
    precondition {
      condition     = var.gpu_node_pool_is_ready
      error_message = "GPU node pool ${var.gpu_node_pool_id} not active yet"
    }
  }
  name             = "gpu-operator"
  repository       = "https://helm.ngc.nvidia.com/nvidia"
  chart            = "gpu-operator"
  version          = var.gpu_operator_chart_version
  namespace        = kubernetes_namespace_v1.gpu_operator.metadata.0.name
  create_namespace = false
  atomic           = false
  cleanup_on_fail  = false
  reset_values     = true
  replace          = true
  set {
    name  = "toolkit.version"
    value = var.gpu_operator_toolkit_version
  }
  set {
    name  = "driver.version"
    value = var.gpu_operator_driver_version
  }

  depends_on = [kubernetes_resource_quota_v1.gpu_operator_quota, kubernetes_namespace_v1.gpu_operator]
}

# resource "helm_release" "gpu_operator" {
#   name       = "gpu-operator"
#   chart      = "gpu-operator"
#   repository = "https://helm.ngc.nvidia.com/nvidia"
#   version    = var.gpu_operator_chart_version
#   namespace  = kubernetes_namespace_v1.gpu_operator.metadata.0.name
#   lifecycle {
#     precondition {
#       condition     = var.gpu_node_pool_is_ready
#       error_message = "GPU node pool ${var.gpu_node_pool_id} not ready yet"
#     }
#   }
#   dynamic "set" {
#     for_each = var.cloud_provider_name == "gcp" ? [1] : []
#     content {
#       name  = "hostPaths.driverInstallDir"
#       value = "/home/kubernetes/bin/nvidia"
#     }
#   }
#   dynamic "set" {
#     for_each = var.cloud_provider_name == "gcp" ? [1] : []
#     content {
#       name  = "toolkit.installDir"
#       value = "/home/kubernetes/bin/nvidia"
#     }
#   }
#   dynamic "set" {
#     for_each = var.cloud_provider_name == "gcp" ? [1] : []
#     content {
#       name  = "cdi.enabled"
#       value = "true"
#     }
#   }
#   dynamic "set" {
#     for_each = var.cloud_provider_name == "gcp" ? [1] : []
#     content {
#       name  = "cdi.default"
#       value = "true"
#     }
#   }
#   dynamic "set" {
#     for_each = var.cloud_provider_name == "gcp" ? [1] : []
#     content {
#       name  = "driver.enabled"
#       value = "false"
#     }
#   }
#   depends_on = [kubernetes_resource_quota_v1.gpu_operator_quota]
# }
