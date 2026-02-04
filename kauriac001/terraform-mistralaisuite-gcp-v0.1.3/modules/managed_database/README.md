Provisions a Cloud SQL PostgreSQL instance

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.48.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.cloudsql_client](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_sql_database.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | CloudSQL Instance Availability Type | `string` | `"REGIONAL"` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Database Name | `string` | `"main"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Database Version | `string` | `"POSTGRES_17"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | CloudSQL Instance Deletion Protection flag. Set to true to prevent accidental deletion of the Instance | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | CloudSQL Instance Disk Size | `number` | `100` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | CloudSQL Instance Disk Type | `string` | `"PD_SSD"` | no |
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS Crypto Key ID to encrypt the CloudSQL Instance Disk | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | CloudSQL Instance Name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account Email that will be granted access to the CloudSQL Instance | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | CloudSQL Instance Tier | `string` | `"db-perf-optimized-N-8"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database Name |
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | Instance Connection Name |
| <a name="output_instance_password"></a> [instance\_password](#output\_instance\_password) | Instance Password |
| <a name="output_instance_private_ip_address"></a> [instance\_private\_ip\_address](#output\_instance\_private\_ip\_address) | Instance Private IP Address |
| <a name="output_instance_username"></a> [instance\_username](#output\_instance\_username) | Instance Username |
<!-- END_TF_DOCS -->
