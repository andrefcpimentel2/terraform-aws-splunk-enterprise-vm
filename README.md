# terraform-aws-splunk-enterprise-vm
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.80.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.5 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.splunk_ent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.gw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.demostack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_main_route_table_association.association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/main_route_table_association) | resource |
| [aws_network_interface.network_interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_security_group.splunk_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.my_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.my_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.AZ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [cloudinit_config.servers](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | The CIDR blocks to create the workstations in. | `string` | `"10.1.1.0/24"` | no |
| <a name="input_created-by"></a> [created-by](#input\_created-by) | Tag used to identify resources created programmatically by Terraform | `string` | `"Terraform"` | no |
| <a name="input_hashi_region"></a> [hashi\_region](#input\_hashi\_region) | the region the owner belongs in.  e.g. NA-WEST-ENT, EU-CENTRAL | `string` | `"EMEA"` | no |
| <a name="input_host_access_ip"></a> [host\_access\_ip](#input\_host\_access\_ip) | CIDR blocks allowed to connect via SSH on port 22 | `list` | `[]` | no |
| <a name="input_instance_type_server"></a> [instance\_type\_server](#input\_instance\_type\_server) | The type(size) of data servers (consul, nomad, etc). | `string` | `"m4.large"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | this is the differantiates different demostack deployment on the same subscription, everycluster should have a different value | `string` | `"demostack"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Email address of the user responsible for lifecycle of cloud resources used for training. | `any` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The contents of the SSH public key to use for connecting to the cluster. | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to create resources. | `string` | `"eu-west-2"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The top-level CIDR block for the VPC. | `string` | `"10.1.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_splunk_addr"></a> [splunk\_addr](#output\_splunk\_addr) | n/a |
| <a name="output_splunk_username"></a> [splunk\_username](#output\_splunk\_username) | n/a |
| <a name="output_token_value"></a> [token\_value](#output\_token\_value) | n/a |
