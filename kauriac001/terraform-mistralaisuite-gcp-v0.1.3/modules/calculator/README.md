This Terraform module calculates the number of CPU and GPU nodes required to run the Mistral AI Suite based on the models and configuration provided in the Helm chart values.

## Overview

The Mistral AI Suite Resource Calculator helps infrastructure teams determine the optimal number of compute nodes needed to deploy the Mistral AI Suite in Kubernetes clusters across different cloud providers (AWS, Azure, GCP).

The calculator:
1. Generates Kubernetes manifests using Helm templates
2. Analyzes resource requests (CPU/GPU) from all deployments
3. Queries cloud provider APIs for machine specifications
4. Calculates required nodes with appropriate buffering

## How It Works

The calculation follows these steps:

1. **Manifest Generation**: Uses `helm template` to generate Kubernetes manifests from the provided chart and values
2. **Resource Analysis**: Parses all Deployment and StatefulSet resources to:
   - Extract CPU and GPU requests from container specifications
   - Calculate total resource requirements across all pods
   - Apply a 20% buffer to CPU requirements for headroom
3. **Cloud Provider Integration**: Queries the specified cloud provider to get:
   - Available zones for the selected machine types
   - CPU and GPU capacity of the selected node types
4. **Node Calculation**: Determines the minimum number of nodes needed by:
   - Dividing total GPU requirements by GPU capacity per node (rounded up)
   - Dividing buffered CPU requirements by CPU capacity per node (rounded up)

## Calculation Details

### CPU Calculation

1. Sum all CPU requests from non-GPU containers across all pods
2. Apply 20% buffer to account for system overhead and spikes
3. Divide by CPU capacity of the selected node type (rounded up)

### GPU Calculation

1. Sum all GPU requests from all containers across all pods
2. Divide by GPU capacity of the selected node type (rounded up)

### Buffering

The calculator adds a 20% buffer to CPU requirements to ensure there's adequate headroom for:
- System processes and Kubernetes overhead
- Resource spikes during peak usage
- Future growth and scaling


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.5 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.calculator_check](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [external_external.calculator](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider_name"></a> [cloud\_provider\_name](#input\_cloud\_provider\_name) | Cloud Provider Name | `string` | n/a | yes |
| <a name="input_cloud_region"></a> [cloud\_region](#input\_cloud\_region) | Cloud Provider Region | `string` | n/a | yes |
| <a name="input_cloud_tenant_id"></a> [cloud\_tenant\_id](#input\_cloud\_tenant\_id) | Cloud Tenant ID. Either AWS Profile, Azure Subscription ID, or GCP Project ID | `string` | n/a | yes |
| <a name="input_cpu_node_type"></a> [cpu\_node\_type](#input\_cpu\_node\_type) | CPU Node Type | `string` | n/a | yes |
| <a name="input_gpu_node_type"></a> [gpu\_node\_type](#input\_gpu\_node\_type) | GPU Node Type | `string` | n/a | yes |
| <a name="input_mistral_ai_suite_chart_uri"></a> [mistral\_ai\_suite\_chart\_uri](#input\_mistral\_ai\_suite\_chart\_uri) | Mistral AI Suite Helm Chart URI | `string` | `"oci://cdn-images.mistralai.com/helm/mistral-ai-suite"` | no |
| <a name="input_mistral_ai_suite_chart_values_files"></a> [mistral\_ai\_suite\_chart\_values\_files](#input\_mistral\_ai\_suite\_chart\_values\_files) | Mistral AI Suite Helm Chart Values Files | `list(string)` | <pre>[<br/>  "values.yaml"<br/>]</pre> | no |
| <a name="input_mistral_ai_suite_chart_version"></a> [mistral\_ai\_suite\_chart\_version](#input\_mistral\_ai\_suite\_chart\_version) | Mistral AI Suite Helm Chart Version | `string` | `"1.3.6"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cpu_node_count"></a> [cpu\_node\_count](#output\_cpu\_node\_count) | CPU Node Count |
| <a name="output_cpu_per_gpu_node"></a> [cpu\_per\_gpu\_node](#output\_cpu\_per\_gpu\_node) | n/a |
| <a name="output_gpu_node_count"></a> [gpu\_node\_count](#output\_gpu\_node\_count) | GPU Node Count |
| <a name="output_gpu_per_gpu_node"></a> [gpu\_per\_gpu\_node](#output\_gpu\_per\_gpu\_node) | n/a |
| <a name="output_node_zones"></a> [node\_zones](#output\_node\_zones) | Node Zones |
| <a name="output_total_cpu_requests"></a> [total\_cpu\_requests](#output\_total\_cpu\_requests) | n/a |
| <a name="output_total_gpu_requests"></a> [total\_gpu\_requests](#output\_total\_gpu\_requests) | n/a |
<!-- END_TF_DOCS -->
