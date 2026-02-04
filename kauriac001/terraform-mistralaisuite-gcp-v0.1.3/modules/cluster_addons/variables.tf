variable "kms_crypto_key_id" {
    type = string
    description = "KMS Crypto Key ID"
    default = ""
}
variable "node_zones" {
    type = list(string)
    description = "List of zones where the GKE cluster nodes are deployed"
    default = []
}
variable "non_masquerade_cidrs" {
    type = list(string)
    description = "List of CIDR ranges that should not be masqueraded by ip-masq-agent. Includes PSC endpoints, link-local addresses, and cluster network ranges (pods, nodes, services)."
}