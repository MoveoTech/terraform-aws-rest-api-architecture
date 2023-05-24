<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | >= 1.3.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_mongodbatlas"></a> [mongodbatlas](#provider\_mongodbatlas) | >= 1.3.1 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Atlas database prodect ID | `string` | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_user_db"></a> [user\_db](#output\_user\_db) | Database username |
| <a name="output_user_db_pass"></a> [user\_db\_pass](#output\_user\_db\_pass) | Database password |
<!-- END_TF_DOCS -->