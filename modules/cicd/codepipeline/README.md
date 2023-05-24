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
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Branch name | `string` | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Pipline bucket name | `any` | yes |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | Deployment configuration | `any` | yes |
| <a name="input_deploy_provider"></a> [deploy\_provider](#input\_deploy\_provider) | This is the deploy provider type | `string` | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization name | `string` | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Name of github token | `string` | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of pipeline | `string` | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of CodeBuild project | `string` | yes |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of repository | `string` | yes |
| <a name="input_s3_bucket_access_log_bucket_name"></a> [s3\_bucket\_access\_log\_bucket\_name](#input\_s3\_bucket\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | yes |
| <a name="input_cf_distribution_id"></a> [cf\_distribution\_id](#input\_cf\_distribution\_id) | Cloudfron distribution id | `string` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | KMS key to encrypt artifact | `string` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Lambda function name for invalidate clodfront | `string` | no |
| <a name="input_poll_for_source_changes"></a> [poll\_for\_source\_changes](#input\_poll\_for\_source\_changes) | if true, a pipeline execution will be triggered on every push | `bool` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->