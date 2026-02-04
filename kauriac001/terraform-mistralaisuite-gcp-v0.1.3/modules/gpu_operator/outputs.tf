output "namespace" {
  description = "GPU Operator Namespace"
  value       = kubernetes_namespace_v1.gpu_operator.metadata[0].name
}

output "helm_release" {
  description = "GPU Operator Helm Release"
  value       = helm_release.gpu_operator
}
