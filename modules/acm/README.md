<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Providers

No providers.

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued | `string` | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | enabled | `bool` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | A list of domains that should be SANs in the issued certificate | `list(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_request_certificate_arn"></a> [acm\_request\_certificate\_arn](#output\_acm\_request\_certificate\_arn) | Certificate ARN's for the creates acm |
<!-- END_TF_DOCS -->