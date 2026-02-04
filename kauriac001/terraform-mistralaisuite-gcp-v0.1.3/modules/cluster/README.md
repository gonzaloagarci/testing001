Creates the GKE cluster with CPU and GPU node pools
 
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.cpu_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_container_node_pool.gpu_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_project_iam_member.gke_node_sa_default_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_compute_subnetwork.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork) | data source |
| [google_container_engine_versions.latest](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/container_engine_versions) | data source |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autopilot"></a> [autopilot](#input\_autopilot) | Whether to enable GKE autopilot or not | `bool` | `false` | no |
| <a name="input_cpu_node_disk_size_gb"></a> [cpu\_node\_disk\_size\_gb](#input\_cpu\_node\_disk\_size\_gb) | CPU Node Disk Size in GiB | `number` | `150` | no |
| <a name="input_cpu_node_max_count"></a> [cpu\_node\_max\_count](#input\_cpu\_node\_max\_count) | CPU Node Max Count | `number` | `1` | no |
| <a name="input_cpu_node_min_count"></a> [cpu\_node\_min\_count](#input\_cpu\_node\_min\_count) | CPU Node Min Count | `number` | `1` | no |
| <a name="input_cpu_node_pool_name"></a> [cpu\_node\_pool\_name](#input\_cpu\_node\_pool\_name) | CPU Node Pool Name | `string` | n/a | yes |
| <a name="input_cpu_node_type"></a> [cpu\_node\_type](#input\_cpu\_node\_type) | CPU Node Type | `string` | `"n1-standard-1"` | no |
| <a name="input_cpu_node_use_preemptible"></a> [cpu\_node\_use\_preemptible](#input\_cpu\_node\_use\_preemptible) | CPU Node Use Preemptible instances | `bool` | `false` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Deletion Protection | `bool` | `false` | no |
| <a name="input_enable_integrity_monitoring"></a> [enable\_integrity\_monitoring](#input\_enable\_integrity\_monitoring) | Enable Integrity Monitoring | `bool` | `true` | no |
| <a name="input_enable_secure_boot"></a> [enable\_secure\_boot](#input\_enable\_secure\_boot) | Enable Secure Boot. Not compatible with the GPU operator. To keep at false if you want to use the GPU operator. | `bool` | `false` | no |
| <a name="input_gpu_driver_version"></a> [gpu\_driver\_version](#input\_gpu\_driver\_version) | GPU Driver Version | `string` | `"LATEST"` | no |
| <a name="input_gpu_node_disk_size_gb"></a> [gpu\_node\_disk\_size\_gb](#input\_gpu\_node\_disk\_size\_gb) | GPU Node Disk Size in GiB | `number` | `150` | no |
| <a name="input_gpu_node_gpu_count"></a> [gpu\_node\_gpu\_count](#input\_gpu\_node\_gpu\_count) | GPU Node GPU Count | `number` | `1` | no |
| <a name="input_gpu_node_gpu_type"></a> [gpu\_node\_gpu\_type](#input\_gpu\_node\_gpu\_type) | GPU Node GPU Type | `string` | `"nvidia-h100-80gb"` | no |
| <a name="input_gpu_node_local_ssd_count"></a> [gpu\_node\_local\_ssd\_count](#input\_gpu\_node\_local\_ssd\_count) | GPU Node Local SSD Count | `number` | `0` | no |
| <a name="input_gpu_node_max_count"></a> [gpu\_node\_max\_count](#input\_gpu\_node\_max\_count) | GPU Node Max Count | `number` | `1` | no |
| <a name="input_gpu_node_min_count"></a> [gpu\_node\_min\_count](#input\_gpu\_node\_min\_count) | GPU Node Min Count | `number` | `1` | no |
| <a name="input_gpu_node_pool_name"></a> [gpu\_node\_pool\_name](#input\_gpu\_node\_pool\_name) | GPU Node Pool Name | `string` | n/a | yes |
| <a name="input_gpu_node_tags"></a> [gpu\_node\_tags](#input\_gpu\_node\_tags) | GPU Node Tags | `list(string)` | `[]` | no |
| <a name="input_gpu_node_type"></a> [gpu\_node\_type](#input\_gpu\_node\_type) | GPU Node Type | `string` | `"a3-highgpu-1g"` | no |
| <a name="input_gpu_node_use_preemptible"></a> [gpu\_node\_use\_preemptible](#input\_gpu\_node\_use\_preemptible) | GPU Node Use Preemptible instances | `bool` | `false` | no |
| <a name="input_gpu_reservation_name"></a> [gpu\_reservation\_name](#input\_gpu\_reservation\_name) | GPU Reservation Name | `string` | `""` | no |
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS Crypto Key ID | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Cluster Name | `string` | n/a | yes |
| <a name="input_node_zones"></a> [node\_zones](#input\_node\_zones) | Node Zones | `list(string)` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | `"europe-west4"` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Cluster Release Channel | `string` | `"REGULAR"` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account Email | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnetwork Name | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Cluster CA Certificate |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Cluster Endpoint |
| <a name="output_cluster_get_creds_cmd"></a> [cluster\_get\_creds\_cmd](#output\_cluster\_get\_creds\_cmd) | Command to get cluster credentials |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster Name |
| <a name="output_cpu_node_pool_id"></a> [cpu\_node\_pool\_id](#output\_cpu\_node\_pool\_id) | CPU Node Pool ID |
| <a name="output_cpu_node_pool_name"></a> [cpu\_node\_pool\_name](#output\_cpu\_node\_pool\_name) | CPU Node Pool Name |
| <a name="output_gpu_node_pool_id"></a> [gpu\_node\_pool\_id](#output\_gpu\_node\_pool\_id) | GPU Node Pool ID |
| <a name="output_gpu_node_pool_name"></a> [gpu\_node\_pool\_name](#output\_gpu\_node\_pool\_name) | GPU Node Pool Name |
<!-- END_TF_DOCS -->
