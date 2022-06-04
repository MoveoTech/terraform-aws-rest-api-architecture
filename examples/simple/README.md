<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.2 |

## Providers

No providers.

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_atlas_org_id"></a> [atlas\_org\_id](#input\_atlas\_org\_id) | The ID of your MongoDB Atlas organisation | `string` | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | The private API key for MongoDB Atlas | `string` | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public API key for MongoDB Atlas | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_url"></a> [client\_url](#output\_client\_url) | The client url |
| <a name="output_server_url"></a> [server\_url](#output\_server\_url) | The server api url |
<!-- END_TF_DOCS -->