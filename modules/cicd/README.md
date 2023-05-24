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
| <a name="input_cf_distribution_id"></a> [cf\_distribution\_id](#input\_cf\_distribution\_id) | Cloudfront distribution id | `string` | yes |
| <a name="input_client_branch_name"></a> [client\_branch\_name](#input\_client\_branch\_name) | Client branch name | `string` | yes |
| <a name="input_client_bucket_name"></a> [client\_bucket\_name](#input\_client\_bucket\_name) | The bucket where the client files are found | `string` | yes |
| <a name="input_client_buildspec_path"></a> [client\_buildspec\_path](#input\_client\_buildspec\_path) | Full path to the place where the buildspec.yml for client ci | `string` | yes |
| <a name="input_client_env_prefix"></a> [client\_env\_prefix](#input\_client\_env\_prefix) | Prefix for react envoiremnt variable, this added for supporting NX prefix | `string` | yes |
| <a name="input_client_repository_name"></a> [client\_repository\_name](#input\_client\_repository\_name) | Client repository name | `string` | yes |
| <a name="input_cognito_pool_id"></a> [cognito\_pool\_id](#input\_cognito\_pool\_id) | Cognito pool id to configure the authentication | `string` | yes |
| <a name="input_cognito_web_client_id"></a> [cognito\_web\_client\_id](#input\_cognito\_web\_client\_id) | Cognito web client id to configure the authentication | `string` | yes |
| <a name="input_elastic_beanstalk_application_name"></a> [elastic\_beanstalk\_application\_name](#input\_elastic\_beanstalk\_application\_name) | Elastic beanstalk app name | `string` | yes |
| <a name="input_elastic_beanstalk_environment_name"></a> [elastic\_beanstalk\_environment\_name](#input\_elastic\_beanstalk\_environment\_name) | Elastic beanstalk environment name | `string` | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Github organization name | `string` | yes |
| <a name="input_invoke_url"></a> [invoke\_url](#input\_invoke\_url) | The URL to invoke the API pointing to the stage, e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod | `string` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs of the created private subnets | `list(string)` | yes |
| <a name="input_region"></a> [region](#input\_region) | aws region to deploy to | `string` | yes |
| <a name="input_s3_bucket_access_log_bucket_name"></a> [s3\_bucket\_access\_log\_bucket\_name](#input\_s3\_bucket\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | yes |
| <a name="input_server_branch_name"></a> [server\_branch\_name](#input\_server\_branch\_name) | Server branch name | `string` | yes |
| <a name="input_server_buildspec_path"></a> [server\_buildspec\_path](#input\_server\_buildspec\_path) | Full path to the place where the buildspec.yml for server ci | `string` | yes |
| <a name="input_server_repository_name"></a> [server\_repository\_name](#input\_server\_repository\_name) | Server repository name | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_codebuild_client_env_vars"></a> [codebuild\_client\_env\_vars](#input\_codebuild\_client\_env\_vars) | Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' } | `list(object({ name = string, value = string, type = string }))` | no |
| <a name="input_codebuild_server_env_vars"></a> [codebuild\_server\_env\_vars](#input\_codebuild\_server\_env\_vars) | Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' } | `list(object({ name = string, value = string, type = string }))` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_poll_for_source_changes"></a> [poll\_for\_source\_changes](#input\_poll\_for\_source\_changes) | if true, a pipeline execution will be triggered on every push | `bool` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->