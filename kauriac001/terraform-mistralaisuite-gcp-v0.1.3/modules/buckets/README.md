Creates Cloud Storage buckets

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
| [google_storage_bucket.apps](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.backups](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket.models](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.apps_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.backups_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.models_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps_create"></a> [apps\_create](#input\_apps\_create) | Apps Bucket Creation flag | `bool` | n/a | yes |
| <a name="input_apps_name"></a> [apps\_name](#input\_apps\_name) | Apps Bucket Name | `string` | n/a | yes |
| <a name="input_backups_create"></a> [backups\_create](#input\_backups\_create) | Backups Bucket Creation flag | `bool` | n/a | yes |
| <a name="input_backups_name"></a> [backups\_name](#input\_backups\_name) | Backups Bucket Name | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Bucket Force Destroy flag | `bool` | n/a | yes |
| <a name="input_kms_crypto_key_id"></a> [kms\_crypto\_key\_id](#input\_kms\_crypto\_key\_id) | KMS Crypto Key ID to encrypt the Buckets | `string` | `""` | no |
| <a name="input_models_create"></a> [models\_create](#input\_models\_create) | Models Bucket Creation flag | `bool` | n/a | yes |
| <a name="input_models_name"></a> [models\_name](#input\_models\_name) | Models Bucket Name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account Email that will be granted access to the Buckets | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Bucket Storage Class | `string` | n/a | yes |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Bucket Versioning Enabled flag | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apps_location"></a> [apps\_location](#output\_apps\_location) | Bucket Apps Location |
| <a name="output_apps_name"></a> [apps\_name](#output\_apps\_name) | Bucket Apps Name |
| <a name="output_apps_url"></a> [apps\_url](#output\_apps\_url) | Bucket Apps URL |
| <a name="output_backups_location"></a> [backups\_location](#output\_backups\_location) | Bucket Backups Location |
| <a name="output_backups_name"></a> [backups\_name](#output\_backups\_name) | Bucket Backups Name |
| <a name="output_backups_url"></a> [backups\_url](#output\_backups\_url) | Bucket Backups URL |
| <a name="output_models_location"></a> [models\_location](#output\_models\_location) | Bucket Models Location |
| <a name="output_models_name"></a> [models\_name](#output\_models\_name) | Bucket Models Name |
| <a name="output_models_url"></a> [models\_url](#output\_models\_url) | Bucket Models URL |
<!-- END_TF_DOCS -->
