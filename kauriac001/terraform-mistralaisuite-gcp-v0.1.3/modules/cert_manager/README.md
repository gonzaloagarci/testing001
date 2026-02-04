<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.cert_manager_dns_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cert_manager](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.cert_manager_wi](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_service_account.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_manager_acme_email"></a> [cert\_manager\_acme\_email](#input\_cert\_manager\_acme\_email) | ACME Email for Let's Encrypt | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace | `string` | `"cert-manager"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_manager_namespace"></a> [cert\_manager\_namespace](#output\_cert\_manager\_namespace) | cert-manager namespace |
| <a name="output_cert_manager_sa_email"></a> [cert\_manager\_sa\_email](#output\_cert\_manager\_sa\_email) | cert-manager email address |
<!-- END_TF_DOCS -->