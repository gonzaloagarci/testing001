output "storage_class_name" {
  value = kubernetes_storage_class_v1.filestore_rwx.metadata[0].name
}