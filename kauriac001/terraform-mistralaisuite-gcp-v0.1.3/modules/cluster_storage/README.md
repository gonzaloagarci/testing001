<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_storage_class_v1.filestore_rwx](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_reserved_ip_range"></a> [reserved\_ip\_range](#input\_reserved\_ip\_range) | Reserved IP Range. Leave blank for auto. | `string` | `null` | no |
| <a name="input_storage_class_name"></a> [storage\_class\_name](#input\_storage\_class\_name) | Storage Class name | `string` | `"standard-rwx"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_class_name"></a> [storage\_class\_name](#output\_storage\_class\_name) | n/a |
<!-- END_TF_DOCS -->