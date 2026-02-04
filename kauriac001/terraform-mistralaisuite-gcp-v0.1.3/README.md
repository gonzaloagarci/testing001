# GCP Terraform Module for Mistral AI Suite

This Terraform module deploys the Mistral AI Suite on Google Cloud Platform (GCP) with all necessary infrastructure components.

## Overview

This module provides a comprehensive solution for deploying the Mistral AI Suite on GCP, including:

- Kubernetes cluster with GPU support
- GPU Operator for managing NVIDIA GPUs
- Managed PostgreSQL database
- Networking and security configurations
- Storage solutions (buckets and NFS)
- IAM and KMS configurations

## Module Structure

The module is organized into several submodules:

- **cluster**: Creates the GKE cluster with CPU and GPU node pools
- **gpu_operator**: Deploys the NVIDIA GPU Operator
- **database**: Provisions a Cloud SQL PostgreSQL instance
- **network**: Sets up VPC, subnets, and optional Cloud NAT
- **buckets**: Creates Cloud Storage buckets
- **nfs**: Provisions a Filestore instance for shared storage
- **iam**: Configures IAM roles and service accounts
- **kms**: Sets up KMS encryption
- **calculator**: Calculates resource requirements
- **mistral_ai_suite**: Deploys the Mistral AI Suite Helm chart

## Features

All features are optional and can be enabled/disabled as needed.

### Core Features

- **Automated GKE Cluster**: Creates a Google Kubernetes Engine (GKE) cluster with CPU and GPU node pools
- **GPU Support**: Deploys the NVIDIA GPU Operator for managing GPUs in the cluster
- **Managed Database**: Provisions a Cloud SQL PostgreSQL instance
- **Storage**: Creates Cloud Storage buckets for models, apps, and backups
- **Networking**: Sets up VPC, subnets, and optional Cloud NAT
- **Security**: Configures IAM roles and KMS encryption
- **NFS Support**: Optional Filestore instance for shared storage

### Advanced Features

- **Autopilot Mode**: Bypasses the resource calculator for GKE Autopilot
- **Preemptible Instances**: Option to use preemptible VMs for cost savings
- **Custom Node Types**: Configurable CPU and GPU node types
- **Multiple Zones**: Support for deploying across multiple availability zones
- **Resource Calculator**: Automatically calculates node requirements based on workload

## How to Configure Variables

All variables are described in the [Variables](#inputs) section below. You can also use example variable files in the `./examples` folder.

## How to Configure Mistral AI Suite Helm Chart Values

If you use the terraform module to install the Mistral AI Suite chart, you need to configure the helm chart values before applying the terraform modules.

You can use the value generator form in the documentation to generate the values file: https://docs-onprem.mistral.ai/step-by-step-guides/deployment/helm/deploy-mistral-ai-suite/

For GKE Autopilot mode, use the additional `values-gke-autopilot.yaml` file and ensure it contains all models you want to deploy.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 6.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.49.2 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.30.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_buckets"></a> [buckets](#module\_buckets) | ./modules/buckets | n/a |
| <a name="module_calculator"></a> [calculator](#module\_calculator) | ./modules/calculator | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./modules/cert_manager | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_cluster_storage"></a> [cluster\_storage](#module\_cluster\_storage) | ./modules/cluster_storage | n/a |
| <a name="module_gpu_operator"></a> [gpu\_operator](#module\_gpu\_operator) | ./modules/gpu_operator | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | ./modules/kms | n/a |
| <a name="module_managed_database"></a> [managed\_database](#module\_managed\_database) | ./modules/managed_database | n/a |
| <a name="module_mistral_ai_suite"></a> [mistral\_ai\_suite](#module\_mistral\_ai\_suite) | ./modules/mistral_ai_suite | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_nfs"></a> [nfs](#module\_nfs) | ./modules/nfs | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [google_client_config.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [kubernetes_nodes.gpu_nodes](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/nodes) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_apps_create"></a> [bucket\_apps\_create](#input\_bucket\_apps\_create) | Bucket Apps Create flag. Set to true to create a Bucket for Apps | `bool` | `true` | no |
| <a name="input_bucket_backups_create"></a> [bucket\_backups\_create](#input\_bucket\_backups\_create) | Bucket Backups Create flag. Set to true to create a Bucket for Backups | `bool` | `true` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Bucket Force Destroy flag. Set to true to force-destroy the bucket content on destroy | `bool` | `true` | no |
| <a name="input_bucket_models_create"></a> [bucket\_models\_create](#input\_bucket\_models\_create) | Bucket Models Create flag. Set to true to create a Bucket for Models | `bool` | `true` | no |
| <a name="input_bucket_storage_class"></a> [bucket\_storage\_class](#input\_bucket\_storage\_class) | Bucket Storage Class | `string` | `"STANDARD"` | no |
| <a name="input_bucket_versioning_enabled"></a> [bucket\_versioning\_enabled](#input\_bucket\_versioning\_enabled) | Bucket Versioning Enabled flag. Set to true to enable versioning | `bool` | `false` | no |
| <a name="input_cert_manager_acme_email"></a> [cert\_manager\_acme\_email](#input\_cert\_manager\_acme\_email) | ACME Email for Let's Encrypt (used in ClusterIssuer) | `string` | `""` | no |
| <a name="input_cert_manager_create"></a> [cert\_manager\_create](#input\_cert\_manager\_create) | Whether to create the cert-manager | `bool` | `false` | no |
| <a name="input_cert_manager_namespace"></a> [cert\_manager\_namespace](#input\_cert\_manager\_namespace) | Namespace where cert-manager will be deployed | `string` | `"cert-manager"` | no |
| <a name="input_cluster_autopilot"></a> [cluster\_autopilot](#input\_cluster\_autopilot) | Cluster Autopilot mode. Bypasses the Resource Calculator | `bool` | `false` | no |
| <a name="input_cluster_cpu_node_disk_size_gb"></a> [cluster\_cpu\_node\_disk\_size\_gb](#input\_cluster\_cpu\_node\_disk\_size\_gb) | Cluster CPU Node Disk Size GiB | `number` | `150` | no |
| <a name="input_cluster_cpu_node_max_count"></a> [cluster\_cpu\_node\_max\_count](#input\_cluster\_cpu\_node\_max\_count) | Cluster CPU Node Max Count | `number` | `2` | no |
| <a name="input_cluster_cpu_node_min_count"></a> [cluster\_cpu\_node\_min\_count](#input\_cluster\_cpu\_node\_min\_count) | Cluster CPU Node Min Count | `number` | `1` | no |
| <a name="input_cluster_cpu_node_type"></a> [cluster\_cpu\_node\_type](#input\_cluster\_cpu\_node\_type) | Cluster CPU Node Type | `string` | `"n1-standard-32"` | no |
| <a name="input_cluster_cpu_node_use_preemptible"></a> [cluster\_cpu\_node\_use\_preemptible](#input\_cluster\_cpu\_node\_use\_preemptible) | Cluster CPU Node Use Preemptible instances | `bool` | `false` | no |
| <a name="input_cluster_create"></a> [cluster\_create](#input\_cluster\_create) | Cluster Creation flag. Set to true to create a new Cluster | `bool` | `true` | no |
| <a name="input_cluster_gpu_driver_version"></a> [cluster\_gpu\_driver\_version](#input\_cluster\_gpu\_driver\_version) | Cluster GPU Driver Version | `string` | `"INSTALLATION_DISABLED"` | no |
| <a name="input_cluster_gpu_node_disk_size_gb"></a> [cluster\_gpu\_node\_disk\_size\_gb](#input\_cluster\_gpu\_node\_disk\_size\_gb) | Cluster GPU Node Disk Size GiB | `number` | `150` | no |
| <a name="input_cluster_gpu_node_gpu_count"></a> [cluster\_gpu\_node\_gpu\_count](#input\_cluster\_gpu\_node\_gpu\_count) | Cluster GPU Node GPU Count | `number` | `4` | no |
| <a name="input_cluster_gpu_node_gpu_type"></a> [cluster\_gpu\_node\_gpu\_type](#input\_cluster\_gpu\_node\_gpu\_type) | Cluster GPU Node GPU Type | `string` | `"nvidia-h100-80gb"` | no |
| <a name="input_cluster_gpu_node_local_ssd_count"></a> [cluster\_gpu\_node\_local\_ssd\_count](#input\_cluster\_gpu\_node\_local\_ssd\_count) | Cluster GPU Node Local SSD Count | `number` | `8` | no |
| <a name="input_cluster_gpu_node_max_count"></a> [cluster\_gpu\_node\_max\_count](#input\_cluster\_gpu\_node\_max\_count) | Cluster GPU Node Max Count | `number` | `1` | no |
| <a name="input_cluster_gpu_node_min_count"></a> [cluster\_gpu\_node\_min\_count](#input\_cluster\_gpu\_node\_min\_count) | Cluster GPU Node Min Count | `number` | `1` | no |
| <a name="input_cluster_gpu_node_tags"></a> [cluster\_gpu\_node\_tags](#input\_cluster\_gpu\_node\_tags) | Cluster GPU Node Tags to apply to all nodes | `list(string)` | `[]` | no |
| <a name="input_cluster_gpu_node_type"></a> [cluster\_gpu\_node\_type](#input\_cluster\_gpu\_node\_type) | Cluster GPU Node Type | `string` | `"a3-highgpu-4g"` | no |
| <a name="input_cluster_gpu_node_use_preemptible"></a> [cluster\_gpu\_node\_use\_preemptible](#input\_cluster\_gpu\_node\_use\_preemptible) | Cluster GPU Node Use Preemptible instances | `bool` | `false` | no |
| <a name="input_cluster_gpu_reservation_name"></a> [cluster\_gpu\_reservation\_name](#input\_cluster\_gpu\_reservation\_name) | Cluster GPU Reservation Name | `string` | `""` | no |
| <a name="input_cluster_node_zones"></a> [cluster\_node\_zones](#input\_cluster\_node\_zones) | Cluster Node Zones | `list(string)` | `[]` | no |
| <a name="input_cluster_release_channel"></a> [cluster\_release\_channel](#input\_cluster\_release\_channel) | Cluster Release Channel | `string` | `"REGULAR"` | no |
| <a name="input_cluster_use_calculator"></a> [cluster\_use\_calculator](#input\_cluster\_use\_calculator) | Cluster Use Resource Calculator flag. Set to true to size the cluster node pools min/max nodes | `bool` | `true` | no |
| <a name="input_default_labels"></a> [default\_labels](#input\_default\_labels) | Default Labels to apply to all resources | `map(string)` | \1\{}` | no |
| <a name="input_gpu_operator_chart_install"></a> [gpu\_operator\_chart\_install](#input\_gpu\_operator\_chart\_install) | Helm GPU Operator Install Driver flag. Set to true to install the NVIDIA Driver | `bool` | `true` | no |
| <a name="input_gpu_operator_chart_version"></a> [gpu\_operator\_chart\_version](#input\_gpu\_operator\_chart\_version) | Helm GPU Operator Version. Not set when `nvaie` is set to `true` | `string` | `"v24.9.0"` | no |
| <a name="input_gpu_operator_driver_version"></a> [gpu\_operator\_driver\_version](#input\_gpu\_operator\_driver\_version) | Helm GPU Operator NVIDIA Driver Version | `string` | `"570.133.20"` | no |
| <a name="input_gpu_operator_namespace"></a> [gpu\_operator\_namespace](#input\_gpu\_operator\_namespace) | Helm GPU Operator Namespace | `string` | `"gpu-operator"` | no |
| <a name="input_gpu_operator_toolkit_version"></a> [gpu\_operator\_toolkit\_version](#input\_gpu\_operator\_toolkit\_version) | Helm GPU Operator Toolkit Version | `string` | `"v1.13.1-ubuntu20.04"` | no |
| <a name="input_iam_create"></a> [iam\_create](#input\_iam\_create) | IAM Creation flag. Set to true to create IAM Roles and Bindings. Or provide your own IAM Roles and Bindings | `bool` | `true` | no |
| <a name="input_iam_service_account_creds"></a> [iam\_service\_account\_creds](#input\_iam\_service\_account\_creds) | IAM Service Account Credentials | `string` | `""` | no |
| <a name="input_iam_service_account_email"></a> [iam\_service\_account\_email](#input\_iam\_service\_account\_email) | IAM Service Account Email | `string` | `""` | no |
| <a name="input_kms_create"></a> [kms\_create](#input\_kms\_create) | KMS Creation flag. Set to true to create a KMS Keyring and Crypto Key | `bool` | `true` | no |
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS Crypto Key ID | `string` | `""` | no |
| <a name="input_managed_database_create"></a> [managed\_database\_create](#input\_managed\_database\_create) | Managed Database Creation flag. Set to true to create a Managed PostgreSQL Instance | `bool` | `true` | no |
| <a name="input_mistral_ai_suite_chart_install"></a> [mistral\_ai\_suite\_chart\_install](#input\_mistral\_ai\_suite\_chart\_install) | Mistral AI Suite Deployment flag. Set to true to deploy Mistral AI Suite | `bool` | `true` | no |
| <a name="input_mistral_ai_suite_chart_install_timeout"></a> [mistral\_ai\_suite\_chart\_install\_timeout](#input\_mistral\_ai\_suite\_chart\_install\_timeout) | Mistral AI Suite Helm Chart Install Timeout in seconds | `number` | `900` | no |
| <a name="input_mistral_ai_suite_chart_uri"></a> [mistral\_ai\_suite\_chart\_uri](#input\_mistral\_ai\_suite\_chart\_uri) | Mistral AI Suite Helm Chart URI | `string` | `"oci://cdn-images.mistralai.com/helm/mistral-ai-suite"` | no |
| <a name="input_mistral_ai_suite_chart_values_files"></a> [mistral\_ai\_suite\_chart\_values\_files](#input\_mistral\_ai\_suite\_chart\_values\_files) | Mistral AI Suite Helm Chart Values Files | `list(string)` | <pre>[<br/>  "values.yaml"<br/>]</pre> | no |
| <a name="input_mistral_ai_suite_chart_version"></a> [mistral\_ai\_suite\_chart\_version](#input\_mistral\_ai\_suite\_chart\_version) | Mistral AI Suite Helm Chart Version | `string` | `"1.3.6"` | no |
| <a name="input_mistral_ai_suite_create_registry_secret"></a> [mistral\_ai\_suite\_create\_registry\_secret](#input\_mistral\_ai\_suite\_create\_registry\_secret) | Whether to create the OCI registry secret for mistral-ai-suite | `bool` | `true` | no |
| <a name="input_mistral_ai_suite_namespace"></a> [mistral\_ai\_suite\_namespace](#input\_mistral\_ai\_suite\_namespace) | Mistral AI Suite Namespace | `string` | `"mistral-ai-suite"` | no |
| <a name="input_mistral_ai_suite_oci_registry_host"></a> [mistral\_ai\_suite\_oci\_registry\_host](#input\_mistral\_ai\_suite\_oci\_registry\_host) | Mistral AI Suite OCI Registry Host | `string` | `"cdn-images.mistralai.com"` | no |
| <a name="input_mistral_ai_suite_oci_registry_password"></a> [mistral\_ai\_suite\_oci\_registry\_password](#input\_mistral\_ai\_suite\_oci\_registry\_password) | Mistral AI Suite OCI Registry Password | `string` | n/a | yes |
| <a name="input_mistral_ai_suite_oci_registry_username"></a> [mistral\_ai\_suite\_oci\_registry\_username](#input\_mistral\_ai\_suite\_oci\_registry\_username) | Mistral AI Suite OCI Registry Username | `string` | n/a | yes |
| <a name="input_mistral_ai_suite_release_name"></a> [mistral\_ai\_suite\_release\_name](#input\_mistral\_ai\_suite\_release\_name) | Helm release name for mistral-ai-suite | `string` | `"mai-suite"` | no |
| <a name="input_network_nat_create"></a> [network\_nat\_create](#input\_network\_nat\_create) | Flag to create Cloud NAT for egress internet access. Required for pulling docker images from external registries | `bool` | `true` | no |
| <a name="input_network_subnet_ip_cidr_range_nodes"></a> [network\_subnet\_ip\_cidr\_range\_nodes](#input\_network\_subnet\_ip\_cidr\_range\_nodes) | Network Subnetwork IP CIDR Range for Nodes | `string` | `"10.0.0.0/20"` | no |
| <a name="input_network_subnet_ip_cidr_range_pods"></a> [network\_subnet\_ip\_cidr\_range\_pods](#input\_network\_subnet\_ip\_cidr\_range\_pods) | Network Subnetwork IP CIDR Range for Pods | `string` | `"10.1.0.0/16"` | no |
| <a name="input_network_subnet_ip_cidr_range_services"></a> [network\_subnet\_ip\_cidr\_range\_services](#input\_network\_subnet\_ip\_cidr\_range\_services) | Network Subnetwork IP CIDR Range for Services | `string` | `"10.2.0.0/16"` | no |
| <a name="input_network_subnet_name"></a> [network\_subnet\_name](#input\_network\_subnet\_name) | Network Subnetwork Name | `string` | `""` | no |
| <a name="input_network_vpc_create"></a> [network\_vpc\_create](#input\_network\_vpc\_create) | Network VPC Creation flag. Set to true to create a new VPC | `bool` | `true` | no |
| <a name="input_network_vpc_name"></a> [network\_vpc\_name](#input\_network\_vpc\_name) | Network VPC Name | `string` | `""` | no |
| <a name="input_nfs_capacity_gb"></a> [nfs\_capacity\_gb](#input\_nfs\_capacity\_gb) | NFS Capacity in GiB | `number` | `2560` | no |
| <a name="input_nfs_create"></a> [nfs\_create](#input\_nfs\_create) | NFS Creation flag. Set to true to create a Filestore Instance | `bool` | `true` | no |
| <a name="input_nfs_protocol"></a> [nfs\_protocol](#input\_nfs\_protocol) | NFS Protocol version | `string` | `"NFS_V4_1"` | no |
| <a name="input_nfs_tier"></a> [nfs\_tier](#input\_nfs\_tier) | NFS Tier | `string` | `"REGIONAL"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to apply to all resources | `string` | `"mistral-ai-suite-"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | `"europe-west4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Cluster CA Certificate |
| <a name="output_cluster_cpu_node_pool_id"></a> [cluster\_cpu\_node\_pool\_id](#output\_cluster\_cpu\_node\_pool\_id) | Cluster CPU Node Pool ID |
| <a name="output_cluster_cpu_node_pool_name"></a> [cluster\_cpu\_node\_pool\_name](#output\_cluster\_cpu\_node\_pool\_name) | Cluster CPU Node Pool Name |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Cluster Endpoint |
| <a name="output_cluster_get_creds_cmd"></a> [cluster\_get\_creds\_cmd](#output\_cluster\_get\_creds\_cmd) | Command to get cluster credentials |
| <a name="output_cluster_gpu_node_pool_id"></a> [cluster\_gpu\_node\_pool\_id](#output\_cluster\_gpu\_node\_pool\_id) | Cluster GPU Node Pool ID |
| <a name="output_cluster_gpu_node_pool_name"></a> [cluster\_gpu\_node\_pool\_name](#output\_cluster\_gpu\_node\_pool\_name) | Cluster GPU Node Pool Name |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster Name |
| <a name="output_iam_service_account_creds"></a> [iam\_service\_account\_creds](#output\_iam\_service\_account\_creds) | IAM Service Account Credentials |
| <a name="output_iam_service_account_email"></a> [iam\_service\_account\_email](#output\_iam\_service\_account\_email) | IAM Service Account Email |
| <a name="output_iam_service_account_id"></a> [iam\_service\_account\_id](#output\_iam\_service\_account\_id) | IAM Service Account ID |
| <a name="output_iam_service_account_name"></a> [iam\_service\_account\_name](#output\_iam\_service\_account\_name) | IAM Service Account Name |
| <a name="output_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#output\_kms\_crypto\_key\_id) | KMS Crypto Key ID |
| <a name="output_managed_database_instance_connection_name"></a> [managed\_database\_instance\_connection\_name](#output\_managed\_database\_instance\_connection\_name) | Managed Database Instance Connection Name |
| <a name="output_managed_database_instance_password"></a> [managed\_database\_instance\_password](#output\_managed\_database\_instance\_password) | Managed Database Instance Password |
| <a name="output_managed_database_instance_private_ip_address"></a> [managed\_database\_instance\_private\_ip\_address](#output\_managed\_database\_instance\_private\_ip\_address) | Managed Database Instance Private IP Address |
| <a name="output_managed_database_instance_username"></a> [managed\_database\_instance\_username](#output\_managed\_database\_instance\_username) | Managed Database Instance Username |
| <a name="output_managed_database_name"></a> [managed\_database\_name](#output\_managed\_database\_name) | Managed Database Name |
| <a name="output_network_nat_name"></a> [network\_nat\_name](#output\_network\_nat\_name) | Network NAT Name |
| <a name="output_network_router_name"></a> [network\_router\_name](#output\_network\_router\_name) | Network Router Name |
| <a name="output_network_subnet_id"></a> [network\_subnet\_id](#output\_network\_subnet\_id) | Subnetwork ID |
| <a name="output_network_subnet_ip_cidr_range_nodes"></a> [network\_subnet\_ip\_cidr\_range\_nodes](#output\_network\_subnet\_ip\_cidr\_range\_nodes) | Subnetwork IP CIDR Range for Nodes |
| <a name="output_network_subnet_ip_cidr_range_pods"></a> [network\_subnet\_ip\_cidr\_range\_pods](#output\_network\_subnet\_ip\_cidr\_range\_pods) | Subnetwork IP CIDR Range for Pods |
| <a name="output_network_subnet_ip_cidr_range_services"></a> [network\_subnet\_ip\_cidr\_range\_services](#output\_network\_subnet\_ip\_cidr\_range\_services) | Subnetwork IP CIDR Range for Services |
| <a name="output_network_subnet_name"></a> [network\_subnet\_name](#output\_network\_subnet\_name) | Subnetwork Name |
| <a name="output_network_vpc_id"></a> [network\_vpc\_id](#output\_network\_vpc\_id) | Network VPC ID |
| <a name="output_network_vpc_name"></a> [network\_vpc\_name](#output\_network\_vpc\_name) | NetworkVPC Name |
| <a name="output_nfs_instance_ip_address"></a> [nfs\_instance\_ip\_address](#output\_nfs\_instance\_ip\_address) | NFS Instance IP Address |
| <a name="output_nfs_instance_name"></a> [nfs\_instance\_name](#output\_nfs\_instance\_name) | NFS Instance Name |
| <a name="output_storage_bucket_apps_location"></a> [storage\_bucket\_apps\_location](#output\_storage\_bucket\_apps\_location) | Storage Bucket Apps Location |
| <a name="output_storage_bucket_apps_name"></a> [storage\_bucket\_apps\_name](#output\_storage\_bucket\_apps\_name) | Storage Bucket Apps Name |
| <a name="output_storage_bucket_apps_url"></a> [storage\_bucket\_apps\_url](#output\_storage\_bucket\_apps\_url) | Storage Bucket Apps URL |
| <a name="output_storage_bucket_backups_location"></a> [storage\_bucket\_backups\_location](#output\_storage\_bucket\_backups\_location) | Storage Bucket Backups Location |
| <a name="output_storage_bucket_backups_name"></a> [storage\_bucket\_backups\_name](#output\_storage\_bucket\_backups\_name) | Storage Bucket Backups Name |
| <a name="output_storage_bucket_backups_url"></a> [storage\_bucket\_backups\_url](#output\_storage\_bucket\_backups\_url) | Storage Bucket Backups URL |
| <a name="output_storage_bucket_models_location"></a> [storage\_bucket\_models\_location](#output\_storage\_bucket\_models\_location) | Storage Bucket Models Location |
| <a name="output_storage_bucket_models_name"></a> [storage\_bucket\_models\_name](#output\_storage\_bucket\_models\_name) | Storage Bucket Models Name |
| <a name="output_storage_bucket_models_url"></a> [storage\_bucket\_models\_url](#output\_storage\_bucket\_models\_url) | Storage Bucket Models URL |
<!-- END_TF_DOCS -->