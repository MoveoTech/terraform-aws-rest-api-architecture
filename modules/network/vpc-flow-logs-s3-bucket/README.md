<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.2 |

## Providers

No providers.

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where subnets will be created (e.g. `vpc-aceb2723`) | `string` | yes |
| <a name="input_allow_ssl_requests_only"></a> [allow\_ssl\_requests\_only](#input\_allow\_ssl\_requests\_only) | Set to `true` to require requests to use Secure Socket Layer (HTTPS/SSL). This will explicitly deny access to HTTP requests | `bool` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Number of days after which to expunge the objects | `number` | no |
| <a name="input_flow_log_enabled"></a> [flow\_log\_enabled](#input\_flow\_log\_enabled) | Enable/disable the Flow Log creation. Useful in multi-account environments where the bucket is in one account, but VPC Flow Logs are in different accounts | `bool` | no |
| <a name="input_glacier_transition_days"></a> [glacier\_transition\_days](#input\_glacier\_transition\_days) | Number of days after which to move the data to the glacier storage tier | `number` | no |
| <a name="input_lifecycle_prefix"></a> [lifecycle\_prefix](#input\_lifecycle\_prefix) | Prefix filter. Used to manage object lifecycle events | `string` | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | Enable lifecycle events on this bucket | `bool` | no |
| <a name="input_noncurrent_version_expiration_days"></a> [noncurrent\_version\_expiration\_days](#input\_noncurrent\_version\_expiration\_days) | Specifies when noncurrent object versions expire | `number` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | Specifies when noncurrent object versions transitions | `number` | no |
| <a name="input_standard_transition_days"></a> [standard\_transition\_days](#input\_standard\_transition\_days) | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | no |
| <a name="input_traffic_type"></a> [traffic\_type](#input\_traffic\_type) | The type of traffic to capture. Valid values: `ACCEPT`, `REJECT`, `ALL` | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | Bucket ARN |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | FQDN of bucket |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Bucket Name (aka ID) |
| <a name="output_bucket_prefix"></a> [bucket\_prefix](#output\_bucket\_prefix) | Bucket prefix configured for lifecycle rules |
| <a name="output_flow_log_arn"></a> [flow\_log\_arn](#output\_flow\_log\_arn) | Flow Log ARN |
| <a name="output_flow_log_id"></a> [flow\_log\_id](#output\_flow\_log\_id) | Flow Log ID |
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | KMS Alias ARN |
| <a name="output_kms_alias_name"></a> [kms\_alias\_name](#output\_kms\_alias\_name) | KMS Alias name |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | KMS Key ARN |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | KMS Key ID |
<!-- END_TF_DOCS -->