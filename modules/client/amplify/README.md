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

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_branch"></a> [branch](#input\_branch) | Which branch to fetch from? | `string` | yes |
| <a name="input_client_repository_name"></a> [client\_repository\_name](#input\_client\_repository\_name) | client repository link | `string` | yes |
| <a name="input_enable_auto_branch_creation"></a> [enable\_auto\_branch\_creation](#input\_enable\_auto\_branch\_creation) | should enable auto branch creation in amplify? | `bool` | yes |
| <a name="input_name"></a> [name](#input\_name) | name of the application | `string` | yes |
| <a name="input_enable_auto_build"></a> [enable\_auto\_build](#input\_enable\_auto\_build) | build automatically | `bool` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Amplify app. |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | Default domain for the Amplify app. |
| <a name="output_id"></a> [id](#output\_id) | unique ID of the Amplify app. |
| <a name="output_production_branch"></a> [production\_branch](#output\_production\_branch) | Describes the information about a production branch for an Amplify app. |
<!-- END_TF_DOCS -->