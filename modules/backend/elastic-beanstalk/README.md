<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | <= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | <= 5.0.0 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_autoscale_max"></a> [autoscale\_max](#input\_autoscale\_max) | Maximum instances to launch | `number` | yes |
| <a name="input_autoscale_min"></a> [autoscale\_min](#input\_autoscale\_min) | Minumum instances to launch | `number` | yes |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' } | `map(string)` | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | IDs for private subnets | `list(string)` | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources have been deployed | `string` | yes |
| <a name="input_s3_bucket_access_log_bucket_name"></a> [s3\_bucket\_access\_log\_bucket\_name](#input\_s3\_bucket\_access\_log\_bucket\_name) | Name of the S3 bucket where s3 access log will be sent to | `string` | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id for the VPC where the ECS container instance should be deployed | `string` | yes |
| <a name="input_additional_settings"></a> [additional\_settings](#input\_additional\_settings) | Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html | <pre>list(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>  }))</pre> | no |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Port application is listening on | `number` | no |
| <a name="input_application_subnets"></a> [application\_subnets](#input\_application\_subnets) | List of subnets to place EC2 instances | `list(string)` | no |
| <a name="input_associated_security_group_ids"></a> [associated\_security\_group\_ids](#input\_associated\_security\_group\_ids) | IDs for private subnets | `list(string)` | no |
| <a name="input_autoscale_lower_bound"></a> [autoscale\_lower\_bound](#input\_autoscale\_lower\_bound) | Minimum level of autoscale metric to remove an instance | `number` | no |
| <a name="input_autoscale_lower_increment"></a> [autoscale\_lower\_increment](#input\_autoscale\_lower\_increment) | How many Amazon EC2 instances to remove when performing a scaling activity. | `number` | no |
| <a name="input_autoscale_measure_name"></a> [autoscale\_measure\_name](#input\_autoscale\_measure\_name) | Metric used for your Auto Scaling trigger | `string` | no |
| <a name="input_autoscale_statistic"></a> [autoscale\_statistic](#input\_autoscale\_statistic) | Statistic the trigger should use, such as Average | `string` | no |
| <a name="input_autoscale_unit"></a> [autoscale\_unit](#input\_autoscale\_unit) | Unit for the trigger measurement, such as Bytes | `string` | no |
| <a name="input_autoscale_upper_bound"></a> [autoscale\_upper\_bound](#input\_autoscale\_upper\_bound) | Maximum level of autoscale metric to add an instance | `number` | no |
| <a name="input_autoscale_upper_increment"></a> [autoscale\_upper\_increment](#input\_autoscale\_upper\_increment) | How many Amazon EC2 instances to add when performing a scaling activity | `number` | no |
| <a name="input_availability_zone_selector"></a> [availability\_zone\_selector](#input\_availability\_zone\_selector) | Availability Zone selector | `string` | no |
| <a name="input_aws_elastic_beanstalk_solution_stack"></a> [aws\_elastic\_beanstalk\_solution\_stack](#input\_aws\_elastic\_beanstalk\_solution\_stack) | aws elastic beanstalk solution stack environment | `string` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_description"></a> [description](#input\_description) | Short description of the Environment | `string` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment | `string` | no |
| <a name="input_elb_scheme"></a> [elb\_scheme](#input\_elb\_scheme) | Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC | `string` | no |
| <a name="input_environment_type"></a> [environment\_type](#input\_environment\_type) | Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments) | `string` | no |
| <a name="input_extended_ec2_policy_document"></a> [extended\_ec2\_policy\_document](#input\_extended\_ec2\_policy\_document) | Extensions or overrides for the IAM role assigned to EC2 instances | `string` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Force destroy the S3 bucket for load balancer logs | `bool` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instances type | `string` | no |
| <a name="input_loadbalancer_subnets"></a> [loadbalancer\_subnets](#input\_loadbalancer\_subnets) | List of subnets to place Elastic Load Balancer | `list(string)` | no |
| <a name="input_loadbalancer_type"></a> [loadbalancer\_type](#input\_loadbalancer\_type) | Load Balancer type, e.g. 'application' or 'classic' | `string` | no |
| <a name="input_rolling_update_enabled"></a> [rolling\_update\_enabled](#input\_rolling\_update\_enabled) | Whether to enable rolling update | `bool` | no |
| <a name="input_rolling_update_type"></a> [rolling\_update\_type](#input\_rolling\_update\_type) | `Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances | `string` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | The size of the EBS root volume | `number` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | The type of the EBS root volume | `string` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Elastic Beanstalk Environment tier, e.g. 'WebServer' or 'Worker' | `string` | no |
| <a name="input_updating_max_batch"></a> [updating\_max\_batch](#input\_updating\_max\_batch) | Maximum number of instances to update at once | `number` | no |
| <a name="input_updating_min_in_service"></a> [updating\_min\_in\_service](#input\_updating\_min\_in\_service) | Minimum number of instances in service during update | `number` | no |
| <a name="input_version_label"></a> [version\_label](#input\_version\_label) | Elastic Beanstalk Application version to deploy | `string` | no |
| <a name="input_wait_for_ready_timeout"></a> [wait\_for\_ready\_timeout](#input\_wait\_for\_ready\_timeout) | The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elastic_beanstalk_application"></a> [elastic\_beanstalk\_application](#output\_elastic\_beanstalk\_application) | Elastic Beanstalk Application |
| <a name="output_elastic_beanstalk_application_name"></a> [elastic\_beanstalk\_application\_name](#output\_elastic\_beanstalk\_application\_name) | Elastic Beanstalk Application name |
| <a name="output_elastic_beanstalk_environment_all_settings"></a> [elastic\_beanstalk\_environment\_all\_settings](#output\_elastic\_beanstalk\_environment\_all\_settings) | List of all option settings configured in the environment. These are a combination of default settings and their overrides from setting in the configuration |
| <a name="output_elastic_beanstalk_environment_application"></a> [elastic\_beanstalk\_environment\_application](#output\_elastic\_beanstalk\_environment\_application) | The Elastic Beanstalk Application specified for this environment |
| <a name="output_elastic_beanstalk_environment_autoscaling_groups"></a> [elastic\_beanstalk\_environment\_autoscaling\_groups](#output\_elastic\_beanstalk\_environment\_autoscaling\_groups) | The autoscaling groups used by this environment |
| <a name="output_elastic_beanstalk_environment_ec2_instance_profile_role_name"></a> [elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name](#output\_elastic\_beanstalk\_environment\_ec2\_instance\_profile\_role\_name) | Instance IAM role name |
| <a name="output_elastic_beanstalk_environment_elb_zone_id"></a> [elastic\_beanstalk\_environment\_elb\_zone\_id](#output\_elastic\_beanstalk\_environment\_elb\_zone\_id) | ELB zone id |
| <a name="output_elastic_beanstalk_environment_endpoint"></a> [elastic\_beanstalk\_environment\_endpoint](#output\_elastic\_beanstalk\_environment\_endpoint) | Fully qualified DNS name for the environment |
| <a name="output_elastic_beanstalk_environment_hostname"></a> [elastic\_beanstalk\_environment\_hostname](#output\_elastic\_beanstalk\_environment\_hostname) | DNS hostname |
| <a name="output_elastic_beanstalk_environment_id"></a> [elastic\_beanstalk\_environment\_id](#output\_elastic\_beanstalk\_environment\_id) | ID of the Elastic Beanstalk environment |
| <a name="output_elastic_beanstalk_environment_instances"></a> [elastic\_beanstalk\_environment\_instances](#output\_elastic\_beanstalk\_environment\_instances) | Instances used by this environment |
| <a name="output_elastic_beanstalk_environment_launch_configurations"></a> [elastic\_beanstalk\_environment\_launch\_configurations](#output\_elastic\_beanstalk\_environment\_launch\_configurations) | Launch configurations in use by this environment |
| <a name="output_elastic_beanstalk_environment_load_balancers"></a> [elastic\_beanstalk\_environment\_load\_balancers](#output\_elastic\_beanstalk\_environment\_load\_balancers) | Elastic Load Balancers in use by this environment |
| <a name="output_elastic_beanstalk_environment_name"></a> [elastic\_beanstalk\_environment\_name](#output\_elastic\_beanstalk\_environment\_name) | Name |
| <a name="output_elastic_beanstalk_environment_queues"></a> [elastic\_beanstalk\_environment\_queues](#output\_elastic\_beanstalk\_environment\_queues) | SQS queues in use by this environment |
| <a name="output_elastic_beanstalk_environment_security_group_id"></a> [elastic\_beanstalk\_environment\_security\_group\_id](#output\_elastic\_beanstalk\_environment\_security\_group\_id) | Security group id |
| <a name="output_elastic_beanstalk_environment_setting"></a> [elastic\_beanstalk\_environment\_setting](#output\_elastic\_beanstalk\_environment\_setting) | Settings specifically set for this environment |
| <a name="output_elastic_beanstalk_environment_tier"></a> [elastic\_beanstalk\_environment\_tier](#output\_elastic\_beanstalk\_environment\_tier) | The environment tier |
| <a name="output_elastic_beanstalk_environment_triggers"></a> [elastic\_beanstalk\_environment\_triggers](#output\_elastic\_beanstalk\_environment\_triggers) | Autoscaling triggers in use by this environment |
| <a name="output_load_balancers_arn"></a> [load\_balancers\_arn](#output\_load\_balancers\_arn) | Elastic Load Balancers in use by this environment |
<!-- END_TF_DOCS -->