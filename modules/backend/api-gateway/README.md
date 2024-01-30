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
| <a name="input_cors_domain"></a> [cors\_domain](#input\_cors\_domain) | List of all cors domain relevant to the api gateway resource, for example if we want to be able to allow request from client `[www.client.com,client.com]` | `list(string)` | yes |
| <a name="input_elastic_beanstalk_application_name"></a> [elastic\_beanstalk\_application\_name](#input\_elastic\_beanstalk\_application\_name) | Elastic beanstalk application name | `string` | yes |
| <a name="input_elastic_beanstalk_environment_cname"></a> [elastic\_beanstalk\_environment\_cname](#input\_elastic\_beanstalk\_environment\_cname) | Elastic beanstalk environment name | `string` | yes |
| <a name="input_integration_input_type"></a> [integration\_input\_type](#input\_integration\_input\_type) | The integration input's type. | `string` | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The KMS arn key to encrtypt all logs | `string` | yes |
| <a name="input_nlb_arn"></a> [nlb\_arn](#input\_nlb\_arn) | Network load balncer arn | `string` | yes |
| <a name="input_path_part"></a> [path\_part](#input\_path\_part) | The last path segment of this API resource | `string` | yes |
| <a name="input_user_pool_arn"></a> [user\_pool\_arn](#input\_user\_pool\_arn) | The ARN of the Cognito user pool | `string` | yes |
| <a name="input_access_log_format"></a> [access\_log\_format](#input\_access\_log\_format) | The format of the access log file. | `string` | no |
| <a name="input_acm_request_certificate_arn"></a> [acm\_request\_certificate\_arn](#input\_acm\_request\_certificate\_arn) | Certificate manager ARN | `string` | no |
| <a name="input_allow_headers"></a> [allow\_headers](#input\_allow\_headers) | Allow headers | `list(string)` | no |
| <a name="input_binary_media_types"></a> [binary\_media\_types](#input\_binary\_media\_types) | A list of media types which will be treated as binary types | `list(string)` | no |
| <a name="input_cognito_enabled"></a> [cognito\_enabled](#input\_cognito\_enabled) | Allow cognito authorization on api gateway routes | `bool` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued | `string` | no |
| <a name="input_integration_http_method"></a> [integration\_http\_method](#input\_integration\_http\_method) | The integration HTTP method (GET, POST, PUT, DELETE, HEAD, OPTIONs, ANY, PATCH) specifying how API Gateway will interact with the back end. | `string` | no |
| <a name="input_integration_request_parameters"></a> [integration\_request\_parameters](#input\_integration\_request\_parameters) | Allowed request headers on api gateway routes integrations | `map(string)` | no |
| <a name="input_method_request_parameters"></a> [method\_request\_parameters](#input\_method\_request\_parameters) | Allowed request headers on api gateway routes methods | `map(bool)` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | The logs retention in days | `number` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the REST API |
| <a name="output_invoke_url"></a> [invoke\_url](#output\_invoke\_url) | The URL to invoke the API pointing to the stage, e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod |
<!-- END_TF_DOCS -->