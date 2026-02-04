This Terraform module creates and manages Google Cloud Filestore instances for NFS storage.

## Features

- Creates a Filestore instance for NFS storage
- Supports encryption with KMS keys
- Configures IAM permissions for service accounts
- Provides flexible configuration options

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_filestore_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/filestore_instance) | resource |
| [google_kms_crypto_key_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS Crypto Key ID to encrypt the NFS volume | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Protocol version | `string` | `"NFS_V4_1"` | no |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account Email | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Tier | `string` | `"REGIONAL"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_file_share_name"></a> [instance\_file\_share\_name](#output\_instance\_file\_share\_name) | Instance File Share Name |
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | Instance IP Address |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Instance Name |
<!-- END_TF_DOCS -->
