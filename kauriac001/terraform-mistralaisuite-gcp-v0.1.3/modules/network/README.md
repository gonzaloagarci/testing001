Sets up VPC, subnets, and optional Cloud NAT

## Features

- Creates VPC networks and subnets
- Configures Cloud NAT for egress internet access
- Sets up VPC peering connections
- Provides flexible IP CIDR range configuration

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
| [google_compute_global_address.peering](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_service.servicenetworking](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_networking_connection.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nat_create"></a> [nat\_create](#input\_nat\_create) | Flag to create Cloud NAT for egress internet access | `bool` | `false` | no |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | Name of the Cloud NAT gateway | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | Name of the router for Cloud NAT | `string` | n/a | yes |
| <a name="input_subnet_ip_cidr_range_nodes"></a> [subnet\_ip\_cidr\_range\_nodes](#input\_subnet\_ip\_cidr\_range\_nodes) | Subnetwork IP CIDR Range for Nodes | `string` | `"10.0.0.0/20"` | no |
| <a name="input_subnet_ip_cidr_range_pods"></a> [subnet\_ip\_cidr\_range\_pods](#input\_subnet\_ip\_cidr\_range\_pods) | Subnetwork IP CIDR Range for Pods | `string` | `"10.1.0.0/16"` | no |
| <a name="input_subnet_ip_cidr_range_services"></a> [subnet\_ip\_cidr\_range\_services](#input\_subnet\_ip\_cidr\_range\_services) | Subnetwork IP CIDR Range for Services | `string` | `"10.2.0.0/16"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnetwork Name | `string` | n/a | yes |
| <a name="input_vpc_create"></a> [vpc\_create](#input\_vpc\_create) | VPC Creation flag. Set to true to create a new VPC | `bool` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC Name | `string` | n/a | yes |
| <a name="input_vpc_peering_name"></a> [vpc\_peering\_name](#input\_vpc\_peering\_name) | VPC Peering Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_name"></a> [nat\_name](#output\_nat\_name) | Name of the Cloud NAT gateway |
| <a name="output_router_name"></a> [router\_name](#output\_router\_name) | Name of the router for Cloud NAT |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Subnetwork ID |
| <a name="output_subnet_ip_cidr_range_nodes"></a> [subnet\_ip\_cidr\_range\_nodes](#output\_subnet\_ip\_cidr\_range\_nodes) | Subnetwork IP CIDR Range for Nodes |
| <a name="output_subnet_ip_cidr_range_pods"></a> [subnet\_ip\_cidr\_range\_pods](#output\_subnet\_ip\_cidr\_range\_pods) | Subnetwork IP CIDR Range for Pods |
| <a name="output_subnet_ip_cidr_range_services"></a> [subnet\_ip\_cidr\_range\_services](#output\_subnet\_ip\_cidr\_range\_services) | Subnetwork IP CIDR Range for Services |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Subnetwork Name |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC ID |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | VPC Name |
<!-- END_TF_DOCS -->
