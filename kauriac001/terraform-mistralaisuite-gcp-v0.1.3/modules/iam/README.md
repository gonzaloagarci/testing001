Configures IAM roles and service accounts

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.default_node_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.storage_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Service Account Description | `string` | `"Mistral AI Suite Service Account"` | no |
| <a name="input_name"></a> [name](#input\_name) | Service Account Name | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account_creds"></a> [service\_account\_creds](#output\_service\_account\_creds) | Service Account Credentials |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | Service Account Email |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | Service Account ID |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | Service Account Name |
<!-- END_TF_DOCS -->
