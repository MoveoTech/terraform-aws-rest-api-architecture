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
| <a name="input_cognito_default_user_email"></a> [cognito\_default\_user\_email](#input\_cognito\_default\_user\_email) | This is a default user to be able to login to the system | `string` | yes |
| <a name="input_admin_create_user_config"></a> [admin\_create\_user\_config](#input\_admin\_create\_user\_config) | The configuration for AdminCreateUser requests | `map(any)` | no |
| <a name="input_client_callback_urls"></a> [client\_callback\_urls](#input\_client\_callback\_urls) | List of allowed callback URLs for the identity providers | `list(string)` | no |
| <a name="input_client_default_redirect_uri"></a> [client\_default\_redirect\_uri](#input\_client\_default\_redirect\_uri) | The default redirect URI. Must be in the list of callback URLs | `string` | no |
| <a name="input_client_logout_urls"></a> [client\_logout\_urls](#input\_client\_logout\_urls) | List of allowed logout URLs for the identity providers | `list(string)` | no |
| <a name="input_client_read_attributes"></a> [client\_read\_attributes](#input\_client\_read\_attributes) | List of user pool attributes the application client can read from | `list(string)` | no |
| <a name="input_client_write_attributes"></a> [client\_write\_attributes](#input\_client\_write\_attributes) | List of user pool attributes the application client can write to | `list(string)` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name. concatenated with the environment name | `string` | no |
| <a name="input_explicit_auth_flows"></a> [explicit\_auth\_flows](#input\_explicit\_auth\_flows) | List of explicit auth flows | `list(string)` | no |
| <a name="input_generate_secret"></a> [generate\_secret](#input\_generate\_secret) | Generate a user secret. | `bool` | no |
| <a name="input_number_schemas"></a> [number\_schemas](#input\_number\_schemas) | A container with the number schema attributes of a user pool. Maximum of 50 attributes | `list(any)` | no |
| <a name="input_schemas"></a> [schemas](#input\_schemas) | A container with the schema attributes of a user pool. Maximum of 50 attributes | `list(any)` | no |
| <a name="input_string_schemas"></a> [string\_schemas](#input\_string\_schemas) | A container with the string schema attributes of a user pool. Maximum of 50 attributes | `list(any)` | no |
| <a name="input_user_pool_name"></a> [user\_pool\_name](#input\_user\_pool\_name) | User poll name. concatenated with the environment name | `string` | no |
| <a name="input_verification_message_template"></a> [verification\_message\_template](#input\_verification\_message\_template) | The template of the sign-up verification message | `object({ default_email_option = string, email_message = optional(string), email_subject = optional(string), sms_message = optional(string) })` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_pool_arn"></a> [user\_pool\_arn](#output\_user\_pool\_arn) | The ARN of the REST API |
| <a name="output_user_pool_id"></a> [user\_pool\_id](#output\_user\_pool\_id) | The user pool id |
| <a name="output_web_client_id"></a> [web\_client\_id](#output\_web\_client\_id) | The web client id |
<!-- END_TF_DOCS -->