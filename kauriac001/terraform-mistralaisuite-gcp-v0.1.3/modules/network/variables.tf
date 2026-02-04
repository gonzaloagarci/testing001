variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "vpc_create" {
  type        = bool
  description = "VPC Creation flag. Set to true to create a new VPC"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "vpc_peering_name" {
  type        = string
  description = "VPC Peering Name"
}

variable "subnet_name" {
  type        = string
  description = "Subnetwork Name"
}

variable "subnet_ip_cidr_range_nodes" {
  type        = string
  default     = "10.0.0.0/20"
  description = "Subnetwork IP CIDR Range for Nodes"
}

variable "subnet_ip_cidr_range_pods" {
  type        = string
  default     = "10.1.0.0/16"
  description = "Subnetwork IP CIDR Range for Pods"
}

variable "subnet_ip_cidr_range_services" {
  type        = string
  default     = "10.2.0.0/16"
  description = "Subnetwork IP CIDR Range for Services"
}

variable "nat_create" {
  type        = bool
  default     = false
  description = "Flag to create Cloud NAT for egress internet access"
}

variable "nat_name" {
  type        = string
  description = "Name of the Cloud NAT gateway"
}

variable "router_name" {
  type        = string
  description = "Name of the router for Cloud NAT"
}

variable "load_balancer_ip_create" {
  type        = bool
  description = "Load Balancer IP Creation flag. Set to true to create Public IP for the Network Load Balancer in front of the Ingress-Controller"
}

variable "load_balancer_ip_name" {
  type        = string
  description = "Load Balancer IP Name"
}
