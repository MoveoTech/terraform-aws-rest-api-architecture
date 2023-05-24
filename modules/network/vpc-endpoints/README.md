<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.2 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_default_security_group"></a> [default\_security\_group](#input\_default\_security\_group) | Defualt security group | `string` | yes |
| <a name="input_private_route_table_ids"></a> [private\_route\_table\_ids](#input\_private\_route\_table\_ids) | IDs of the created private route tables | `list(string)` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_vpc_endpoint_cloudformation"></a> [aws\_vpc\_endpoint\_cloudformation](#output\_aws\_vpc\_endpoint\_cloudformation) | Address of the created vpc endpoint |
| <a name="output_aws_vpc_endpoint_elasticbeanstalk"></a> [aws\_vpc\_endpoint\_elasticbeanstalk](#output\_aws\_vpc\_endpoint\_elasticbeanstalk) | Address of the created vpc endpoint |
| <a name="output_aws_vpc_endpoint_elasticbeanstalk_health"></a> [aws\_vpc\_endpoint\_elasticbeanstalk\_health](#output\_aws\_vpc\_endpoint\_elasticbeanstalk\_health) | Address of the created vpc endpoint |
| <a name="output_aws_vpc_endpoint_s3"></a> [aws\_vpc\_endpoint\_s3](#output\_aws\_vpc\_endpoint\_s3) | Address of the created vpc endpoint |
| <a name="output_aws_vpc_endpoint_sqs"></a> [aws\_vpc\_endpoint\_sqs](#output\_aws\_vpc\_endpoint\_sqs) | Address of the created vpc endpoint |
<!-- END_TF_DOCS -->