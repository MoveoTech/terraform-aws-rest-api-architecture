<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | >= 1.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | >= 1.3.1 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_atlas_project_id"></a> [atlas\_project\_id](#input\_atlas\_project\_id) | The ID of your MongoDB Atlas project | `string` | yes |
| <a name="input_mongo_db_major_version"></a> [mongo\_db\_major\_version](#input\_mongo\_db\_major\_version) | Version of the cluster to deploy. Atlas supports the following MongoDB versions for M10+ clusters: 4.2, 4.4, 5.0, or 6.0. | `string` | yes |
| <a name="input_provider_instance_size_name"></a> [provider\_instance\_size\_name](#input\_provider\_instance\_size\_name) | Atlas provides different instance sizes, each with a default storage capacity and RAM size | `string` | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Database cluster name |
| <a name="output_connection_string"></a> [connection\_string](#output\_connection\_string) | The private endpoint-aware cluster connection string |
| <a name="output_connection_string_srv"></a> [connection\_string\_srv](#output\_connection\_string\_srv) | The srv connection string. Example return string: standard\_srv = `mongodb+srv://cluster-atlas.ygo1m.mongodb.net` |
<!-- END_TF_DOCS -->