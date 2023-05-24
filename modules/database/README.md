<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | >= 1.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.2 |
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | >= 1.3.1 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_atlas_users"></a> [atlas\_users](#input\_atlas\_users) | List of emails for all the developer who needs access to this organization project | `list(string)` | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`) | `string` | yes |
| <a name="input_enable_atlas_whitelist_ips"></a> [enable\_atlas\_whitelist\_ips](#input\_enable\_atlas\_whitelist\_ips) | Enable the whitelist ip, if it enabled the ip's taken from the AWS EIP | `bool` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs for private subnets | `list(string)` | yes |
| <a name="input_provider_instance_size_name"></a> [provider\_instance\_size\_name](#input\_provider\_instance\_size\_name) | Atlas provides different instance sizes, each with a default storage capacity and RAM size | `string` | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_atlas_org_id"></a> [atlas\_org\_id](#input\_atlas\_org\_id) | The ID of your MongoDB Atlas organisation | `string` | no |
| <a name="input_atlas_whitelist_ips"></a> [atlas\_whitelist\_ips](#input\_atlas\_whitelist\_ips) | A list of ip's that need access to this project clusters | `list(string)` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_elastic_beanstalk_kms_id"></a> [elastic\_beanstalk\_kms\_id](#input\_elastic\_beanstalk\_kms\_id) | Elastic beanstalk kms key to encrypt the secrets | `string` | no |
| <a name="input_enable_database_credentials_secret_manager"></a> [enable\_database\_credentials\_secret\_manager](#input\_enable\_database\_credentials\_secret\_manager) | Indicate whether or not creating secret manager from the database module | `string` | no |
| <a name="input_private_endpoint_enabled"></a> [private\_endpoint\_enabled](#input\_private\_endpoint\_enabled) | Private endpoint allow to connect between 2 aws accounts by private network no need to use internet. To use this feature you need to add payment card to your atlas account | `bool` | no |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | Atlas MongoDB private key for authentication | `string` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Atlas MongoDB public key for authentication | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_atlas_project_id"></a> [atlas\_project\_id](#output\_atlas\_project\_id) | ID's of the created cluster project |
| <a name="output_atlas_resource_sg_id"></a> [atlas\_resource\_sg\_id](#output\_atlas\_resource\_sg\_id) | ID's of the created security group |
| <a name="output_connection_string_srv"></a> [connection\_string\_srv](#output\_connection\_string\_srv) | The srv connection string. Example return string: standard\_srv = `mongodb+srv://cluster-atlas.ygo1m.mongodb.net` |
| <a name="output_db_connection_string"></a> [db\_connection\_string](#output\_db\_connection\_string) | The private endpoint-aware cluster connection string |
| <a name="output_db_password"></a> [db\_password](#output\_db\_password) | The password of the account with which to access the database |
| <a name="output_db_username"></a> [db\_username](#output\_db\_username) | The username of the account with which to access the database |
<!-- END_TF_DOCS -->