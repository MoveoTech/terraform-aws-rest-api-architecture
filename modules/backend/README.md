<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | <= 5.0.0 |

## Providers

No providers.

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_autoscale_max"></a> [autoscale\_max](#input\_autoscale\_max) | Maximum instances to launch | `number` | yes |
| <a name="input_autoscale_min"></a> [autoscale\_min](#input\_autoscale\_min) | Minumum instances to launch | `number` | yes |
| <a name="input_cors_domain"></a> [cors\_domain](#input\_cors\_domain) | List of all cors domain relevant to the api gateway resource, for example if we want to be able to allow request from client `[www.client.com,client.com]` | `list(string)` | yes |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' } | `map(string)` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region to deploy to | `string` | yes |
| <a name="input_s3_bucket_access_log_bucket_name"></a> [s3\_bucket\_access\_log\_bucket\_name](#input\_s3\_bucket\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | yes |
| <a name="input_user_pool_arn"></a> [user\_pool\_arn](#input\_user\_pool\_arn) | The ARN of the Cognito user pool | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_acm_request_certificate_arn"></a> [acm\_request\_certificate\_arn](#input\_acm\_request\_certificate\_arn) | Certificate manager ARN | `string` | no |
| <a name="input_associated_security_group_ids"></a> [associated\_security\_group\_ids](#input\_associated\_security\_group\_ids) | IDs for private subnets | `list(string)` | no |
| <a name="input_cognito_enabled"></a> [cognito\_enabled](#input\_cognito\_enabled) | Allow cognito authorization on api gateway routes | `bool` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued | `string` | no |
| <a name="input_extended_ec2_policy_document"></a> [extended\_ec2\_policy\_document](#input\_extended\_ec2\_policy\_document) | Extensions or overrides for the IAM role assigned to EC2 instances | `string` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instances type | `string` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_arn"></a> [api\_gateway\_arn](#output\_api\_gateway\_arn) | The ARN of the REST API |
| <a name="output_eb_key_arn"></a> [eb\_key\_arn](#output\_eb\_key\_arn) | Key ARN |
| <a name="output_eb_kms_id"></a> [eb\_kms\_id](#output\_eb\_kms\_id) | KMS key id |
| <a name="output_elastic_beanstalk_application_name"></a> [elastic\_beanstalk\_application\_name](#output\_elastic\_beanstalk\_application\_name) | Elastic Beanstalk Application name |
| <a name="output_elastic_beanstalk_environment_ec2_instance_profile_role_name"></a> [elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name](#output\_elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name) | Instance IAM role name |
| <a name="output_elastic_beanstalk_environment_name"></a> [elastic\_beanstalk\_environment\_name](#output\_elastic\_beanstalk\_environment\_name) | Elastic Beanstalk environment name |
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | The URL to invoke the API pointing to the stage, e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod |
<!-- END_TF_DOCS -->