This Terraform module deploys the NVIDIA GPU Operator on a Kubernetes cluster, providing essential GPU management capabilities for AI workloads.

It is a shared module across our different cloud provider terraform modules.

## Features

- Creates a dedicated namespace for the GPU Operator
- Sets up resource quotas for the GPU Operator
- Deploys the GPU Operator Helm chart with configurable versions
- Supports custom driver and toolkit versions
- Integrates with Kubernetes and Helm providers

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.17.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.38.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.gpu_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.gpu_operator](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_resource_quota_v1.gpu_operator_quota](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/resource_quota_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider_name"></a> [cloud\_provider\_name](#input\_cloud\_provider\_name) | Cloud Provider Name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `string` | n/a | yes |
| <a name="input_gpu_node_pool_id"></a> [gpu\_node\_pool\_id](#input\_gpu\_node\_pool\_id) | GPU Node Pool ID | `string` | n/a | yes |
| <a name="input_gpu_node_pool_is_ready"></a> [gpu\_node\_pool\_is\_ready](#input\_gpu\_node\_pool\_is\_ready) | GPU Node Pool Is Ready flag. This is used to ensure that the GPU node pool is ready before installing the GPU operator | `bool` | n/a | yes |
| <a name="input_gpu_operator_chart_version"></a> [gpu\_operator\_chart\_version](#input\_gpu\_operator\_chart\_version) | GPU Operator Chart Version | `string` | n/a | yes |
| <a name="input_gpu_operator_driver_version"></a> [gpu\_operator\_driver\_version](#input\_gpu\_operator\_driver\_version) | GPU Operator Driver Version | `string` | n/a | yes |
| <a name="input_gpu_operator_namespace"></a> [gpu\_operator\_namespace](#input\_gpu\_operator\_namespace) | GPU Operator Namespace | `string` | `"gpu-operator"` | no |
| <a name="input_gpu_operator_toolkit_version"></a> [gpu\_operator\_toolkit\_version](#input\_gpu\_operator\_toolkit\_version) | GPU Operator Toolkit Version | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release"></a> [helm\_release](#output\_helm\_release) | GPU Operator Helm Release |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | GPU Operator Namespace |
<!-- END_TF_DOCS -->