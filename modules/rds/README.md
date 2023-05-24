<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.4.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_db_parameter_group"></a> [db\_parameter\_group](#input\_db\_parameter\_group) | Parameter group, depends on DB engine used | `string` | yes |
| <a name="input_engine"></a> [engine](#input\_engine) | Database engine type | `string` | yes |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Database engine version, depends on engine type | `string` | yes |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Class of RDS instance | `string` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs for private subnets | `list(string)` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id for the VPC where the ECS container instance should be deployed | `string` | yes |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage in GBs | `number` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `bool` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | Database port (\_e.g.\_ `3306` for `MySQL`). Used in the DB Security Group to allow access to the DB instance from the provided `security_group_ids` | `number` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Set to true if multi AZ deployment must be supported | `bool` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Determines if database can be publicly available (NOT recommended) | `bool` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | IDs for vpc default security group ids | `list(string)` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | (Optional) Specifies whether the DB instance is encrypted. The default is false if not specified | `bool` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD) | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | Database name |
| <a name="output_database_password"></a> [database\_password](#output\_database\_password) | Database password |
| <a name="output_database_user"></a> [database\_user](#output\_database\_user) | Database username |
| <a name="output_instance_address"></a> [instance\_address](#output\_instance\_address) | Address of the instance |
| <a name="output_instance_endpoint"></a> [instance\_endpoint](#output\_instance\_endpoint) | DNS Endpoint of the instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the instance |
<!-- END_TF_DOCS -->