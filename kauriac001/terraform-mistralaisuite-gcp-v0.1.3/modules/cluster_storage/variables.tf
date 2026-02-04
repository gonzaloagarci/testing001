variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "storage_class_name" {
  description = "Storage Class name"
  type        = string
  default     = "standard-rwx"
}

variable "reserved_ip_range" {
  description = "Reserved IP Range. Leave blank for auto."
  type        = string
  default     = null
}