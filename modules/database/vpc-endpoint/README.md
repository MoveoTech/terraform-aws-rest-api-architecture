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
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Atlas database prodect ID | `string` | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Security group id | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->