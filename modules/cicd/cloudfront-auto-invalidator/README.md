<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.2 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name assigned to the function and other resources | `string` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region to deploy to | `string` | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | IDs of the created security group | `string` | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Function memory in MB | `number` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda runtime to use | `string` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Function timeout in seconds | `number` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | ARN's of the created lambda function |
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | Lambda function name |
<!-- END_TF_DOCS -->