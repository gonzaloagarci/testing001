variable "project_id" {
  description = "GCP Project ID where the IP will be created"
  type        = string
}

variable "host_project_id" {
  description = "Shared VPC peoject"
  type        = string
}

variable "region" {
  description = "GCP Region where the IP will be created"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet where the IP will be allocated"
  type        = string
}

variable "load_balancer_ip_name" {
  description = "Name for the load balancer IP address resource"
  type        = string
  default     = "apisix-lb-ip"
}

variable "load_balancer_ip_address" {
  description = "Specific internal IP address for the load balancer (must be within subnet range)"
  type        = string
  default     = null
}