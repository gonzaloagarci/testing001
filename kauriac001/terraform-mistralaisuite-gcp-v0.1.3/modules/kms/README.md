This Terraform module manages Google Cloud KMS resources for the Mistral AI Suite.

## Features

- Creates a KMS key ring and crypto key (optional)
- Manages IAM bindings for the crypto key
- Supports integration with managed databases
- Provides flexible configuration options

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.47.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 6.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.sqladmin](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_kms_crypto_key.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_binding.cloudkms](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_key_ring.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_crypto_key_id"></a> [crypto\_key\_id](#input\_crypto\_key\_id) | Crypto Key ID | `string` | `""` | no |
| <a name="input_crypto_key_name"></a> [crypto\_key\_name](#input\_crypto\_key\_name) | Crypto Key Name | `string` | `"mistral-ai-suite-key"` | no |
| <a name="input_key_ring_name"></a> [key\_ring\_name](#input\_key\_ring\_name) | Key Ring Name | `string` | `"mistral-ai-suite-keyring"` | no |
| <a name="input_kms_create"></a> [kms\_create](#input\_kms\_create) | KMS Create flag. Set to true to create a KMS key ring and crypto key | `bool` | `false` | no |
| <a name="input_managed_database_create"></a> [managed\_database\_create](#input\_managed\_database\_create) | Database Create flag. Set to true to create a managed database | `bool` | `false` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account Email that will be granted access to the KMS key | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_crypto_key_id"></a> [crypto\_key\_id](#output\_crypto\_key\_id) | Crypto Key ID |
<!-- END_TF_DOCS -->
