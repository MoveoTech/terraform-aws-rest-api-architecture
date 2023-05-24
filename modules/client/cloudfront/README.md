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
| <a name="input_s3_bucket_access_log_bucket_name"></a> [s3\_bucket\_access\_log\_bucket\_name](#input\_s3\_bucket\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | yes |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | Existing ACM Certificate ARN | `string` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | `list(string)` | no |
| <a name="input_cloudfront_access_log_create_bucket"></a> [cloudfront\_access\_log\_create\_bucket](#input\_cloudfront\_access\_log\_create\_bucket) | When `true` and `cloudfront_access_logging_enabled` is also true, this module will create a new,<br>separate S3 bucket to receive Cloudfront Access Logs. | `bool` | no |
| <a name="input_cloudfront_access_logging_enabled"></a> [cloudfront\_access\_logging\_enabled](#input\_cloudfront\_access\_logging\_enabled) | Set true to enable delivery of Cloudfront Access Logs to an S3 bucket | `bool` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_dns_alias_enabled"></a> [dns\_alias\_enabled](#input\_dns\_alias\_enabled) | Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name` | `bool` | no |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | no |
| <a name="input_s3_object_ownership"></a> [s3\_object\_ownership](#input\_s3\_object\_ownership) | Specifies the S3 object ownership control on the origin bucket. Valid values are `ObjectWriter`, `BucketOwnerPreferred`, and 'BucketOwnerEnforced'. | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cf_arn"></a> [cf\_arn](#output\_cf\_arn) | ARN of AWS CloudFront distribution |
| <a name="output_cf_domain_name"></a> [cf\_domain\_name](#output\_cf\_domain\_name) | Domain name corresponding to the distribution |
| <a name="output_cf_etag"></a> [cf\_etag](#output\_cf\_etag) | Current version of the distribution's information |
| <a name="output_cf_hosted_zone_id"></a> [cf\_hosted\_zone\_id](#output\_cf\_hosted\_zone\_id) | CloudFront Route 53 zone ID |
| <a name="output_cf_id"></a> [cf\_id](#output\_cf\_id) | ID of AWS CloudFront distribution |
| <a name="output_cf_identity_iam_arn"></a> [cf\_identity\_iam\_arn](#output\_cf\_identity\_iam\_arn) | CloudFront Origin Access Identity IAM ARN |
| <a name="output_cf_origin_groups"></a> [cf\_origin\_groups](#output\_cf\_origin\_groups) | List of Origin Groups in the CloudFront distribution. |
| <a name="output_cf_origin_ids"></a> [cf\_origin\_ids](#output\_cf\_origin\_ids) | List of Origin IDs in the CloudFront distribution. |
| <a name="output_cf_s3_canonical_user_id"></a> [cf\_s3\_canonical\_user\_id](#output\_cf\_s3\_canonical\_user\_id) | Canonical user ID for CloudFront Origin Access Identity |
| <a name="output_cf_status"></a> [cf\_status](#output\_cf\_status) | Current status of the distribution |
| <a name="output_client_url"></a> [client\_url](#output\_client\_url) | Client url |
| <a name="output_s3_bucket"></a> [s3\_bucket](#output\_s3\_bucket) | Name of S3 bucket |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | Domain of S3 bucket |
| <a name="output_s3_bucket_policy"></a> [s3\_bucket\_policy](#output\_s3\_bucket\_policy) | Final computed S3 bucket policy |
<!-- END_TF_DOCS -->