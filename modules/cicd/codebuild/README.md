<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.2 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | CodeBuild Container base image | `string` | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Build | `string` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | IDs of the created security group | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_buildspec_path"></a> [buildspec\_path](#input\_buildspec\_path) | The build spec path in th context of the github repository project | `string` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A list of maps, that contain the keys 'name', 'value', and 'type' to be used as additional environment variables for the build. Valid types are 'PLAINTEXT', 'PARAMETER\_STORE', or 'SECRETS\_MANAGER' | <pre>list(object(<br>    {<br>      name  = string<br>      value = string<br>      type  = string<br>  }))</pre> | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | KMS key to encrypt artifact | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Project name |
<!-- END_TF_DOCS -->