The project goal is to make the developer's life easier from the perspective of repetitive DevOps tasks. 

When using this project you will be able to create AWS Infrastructure for REST API applications, both server, and client. 

This project use [terraform](https://www.terraform.io/) to automate the process of creating and maintaining the infrastructure.

Architecture
---

1. **Application** - 
     * Server example app includes connection to Atlas MongoDB

     * Client example app includes Sign in with MFA, Read/Write events to server API.

2. **Certificate** - Both the server and the client can use a custom domain.

3. **Authentication** - Cognito implementation for user management including MFA.

4. **Mongodb** - Creation of infrastructure for DB and connect by PrivateLink to AWS infrastructure.

5. **Turrgrant** - Easy way to duplicate infrastructure for multiple environments. 

6. **CI/CD** - Auto deployment process by AWS CodePipeline. 

7. **Security** - Each resource is protected by WAF rules.




![Architecture](https://raw.githubusercontent.com/MoveoTech/terraform/c89bbd9c556e8e223d23e39655903dc6d3768072/infrastructure-architecture.drawio.svg)


## Security & Compliance [<img src="https://cloudposse.com/wp-content/uploads/2020/11/bridgecrew.svg" width="250" align="right" />](https://bridgecrew.io/)

Security scanning is graciously provided by Bridgecrew. Bridgecrew is the leading fully hosted, cloud-native solution providing continuous Terraform security and compliance.

| Benchmark | Description |
|--------|---------------|
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/dc0f46bb966d4e3a805d6e769f828849)](https://app.codacy.com/gh/MoveoTech/terraform-aws-rest-api-architecture?utm_source=github.com&utm_medium=referral&utm_content=MoveoTech/terraform-aws-rest-api-architecture&utm_campaign=Badge_Grade_Settings)
| [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=CIS+KUBERNETES+V1.5) | Center for Internet Security, KUBERNETES Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![CIS AZURE](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=CIS+AZURE+V1.1) | Center for Internet Security, AZURE Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![CIS GCP](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=CIS+GCP+V1.1) | Center for Internet Security, GCP Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/moveotech/terraform/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=MoveoTech%2Fterraform&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |





# Installation

AWS CLI installation 
---

Installation Docs [link](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-prereqs.html)

```
brew install awscli
```

> [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)
```cli
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format  [None]: json

```


Terraform installation 
---
> Installation Docs ([link](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started))

> First, install the HashiCorp tap, a repository of all our Homebrew packages.

```
brew tap hashicorp/tap
```


> Now, install Terraform with `hashicorp/tap/terraform`.

```
brew install hashicorp/tap/terraform
```


Terragrunt installation
---
> Installation Docs [link](https://terragrunt.gruntwork.io/docs/getting-started/install/)


```
brew install terragrunt
```



\
&nbsp;
\
&nbsp;


Usage
---

&nbsp;

### Github configuration
Before running the examples you will need to create a Github Personal Access Token that will give terraform access to your repository to be able connecting the repository with AWS Codepipline (CI/CD).

You can follow this [link](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) to create a new Access Token. 


&nbsp;


After creating the github secret you need to save it in the AWS Secret Manager service. 

The name must be: `github_secret`


![image description](https://i.ibb.co/kBwpGwq/secret-manager.png)


In the secret key use the same key: `GitHubPersonalAccessToken`

And the value will be your key you generated from Github.

![image description](https://i.ibb.co/7Qs3QGS/secrets-value.png)

\
&nbsp;
\
&nbsp;

After this stage terraform will be able to connect the github repository with your project.



### Atlas Mongodb configuration

1. Create Mongodb atlas account. [doc link](https://www.mongodb.com/cloud/atlas/register)
2. Create organization API key.  [doc link](https://docs.atlas.mongodb.com/tutorial/configure-api-access/organization/create-one-api-key/)
3. Copy the private and public keys.
4. Create `sensitive.tf` file inside the example folder in this project.

The file should look like this: 

&nbsp;

`sensitive.tf`

```hcl

public_key="eeeeee"
private_key="aaaaaa-bbbb-cccc-54342-5432ggg"
atlas_org_id = "324214321432aaa"

```

&nbsp;

This example will use the minimum required variables to create the infrastructure.
This example doesn't include the ACM custom domain.

`simple.tf`

```hcl
module "infrastructure" {
  source  = "MoveoTech/api-aws/rest"
  version = "0.0.2"

  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "eliran@moveohls.com"
  client_repository_name     = "terraform-rest-api-aws"
  client_branch_name         = "main"
  server_repository_name     = "terraform-rest-api-aws"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
  module                     = var.module
}
```



&nbsp;


This example will use a custom domain and all configurable variables.



`complete.tf`
```hcl


module "infrastructure" {
  source  = "MoveoTech/api-aws/rest"
  version = "0.0.2"

  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  instance_type              = "t3.micro"
  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "dev@moveohls.com"
  client_repository_name     = "terraform-rest-api-aws"
  client_branch_name         = "main"
  server_repository_name     = "terraform-rest-api-aws"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  public_key                 = var.public_key
  private_key                = var.private_key
  atlas_org_id               = var.atlas_org_id
  module                     = var.module

  atlas_users                = ["dev@moveohls.com"]
  private_endpoint_enabled   = true
  enable_atlas_whitelist_ips = false
  atlas_whitelist_ips        = []

  client_logout_urls          = ["https://www.test.terraform.moveodevelop.com/logout"]
  client_default_redirect_uri = "https://www.test.terraform.moveodevelop.com"
  client_callback_urls        = ["https://www.test.terraform.moveodevelop.com"]


  parent_zone_id            = "ZZG2X8KI3MIQB"
  aliases_client            = ["test.terraform.moveodevelop.com", "www.test.terraform.moveodevelop.com"]
  domain_name               = "test.terraform.moveodevelop.com"
  subject_alternative_names = ["www.test.terraform.moveodevelop.com"]
  dns_alias_enabled         = true
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.74.2 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | >= 1.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.74.2 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_atlas_org_id"></a> [atlas\_org\_id](#input\_atlas\_org\_id) | The ID of your MongoDB Atlas organization | `string` | yes |
| <a name="input_client_branch_name"></a> [client\_branch\_name](#input\_client\_branch\_name) | Client branch name | `string` | yes |
| <a name="input_client_repository_name"></a> [client\_repository\_name](#input\_client\_repository\_name) | Client repository name | `string` | yes |
| <a name="input_cognito_default_user_email"></a> [cognito\_default\_user\_email](#input\_cognito\_default\_user\_email) | This is a default user to be able to login to the system | `string` | yes |
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | Github organization name | `string` | yes |
| <a name="input_private_key"></a> [private\_key](#input\_private\_key) | The private API key for MongoDB Atlas | `string` | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public API key for MongoDB Atlas | `string` | yes |
| <a name="input_server_branch_name"></a> [server\_branch\_name](#input\_server\_branch\_name) | Server branch name | `string` | yes |
| <a name="input_server_repository_name"></a> [server\_repository\_name](#input\_server\_repository\_name) | Server repository name | `string` | yes |
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | no |
| <a name="input_aliases_client"></a> [aliases\_client](#input\_aliases\_client) | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | `list(string)` | no |
| <a name="input_atlas_users"></a> [atlas\_users](#input\_atlas\_users) | List of emails for all the developer who needs access to this organization project | `list(string)` | no |
| <a name="input_atlas_whitelist_ips"></a> [atlas\_whitelist\_ips](#input\_atlas\_whitelist\_ips) | A list of ip's that need access to this project clusters | `list(string)` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones for the selected region | `list(string)` | no |
| <a name="input_client_callback_urls"></a> [client\_callback\_urls](#input\_client\_callback\_urls) | List of allowed callback URLs for the identity providers | `list(string)` | no |
| <a name="input_client_default_redirect_uri"></a> [client\_default\_redirect\_uri](#input\_client\_default\_redirect\_uri) | The default redirect URI. Must be in the list of callback URLs | `string` | no |
| <a name="input_client_logout_urls"></a> [client\_logout\_urls](#input\_client\_logout\_urls) | List of allowed logout URLs for the identity providers | `list(string)` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | no |
| <a name="input_dns_alias_enabled"></a> [dns\_alias\_enabled](#input\_dns\_alias\_enabled) | Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name` | `bool` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | A domain name for which the certificate should be issued | `string` | no |
| <a name="input_enable_atlas_whitelist_ips"></a> [enable\_atlas\_whitelist\_ips](#input\_enable\_atlas\_whitelist\_ips) | Enable the whitelist ip, if it enabled the ip's taken from the AWS EIP | `bool` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | no |
| <a name="input_github_secret_name"></a> [github\_secret\_name](#input\_github\_secret\_name) | GitHub key name | `string` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instances type | `string` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | no |
| <a name="input_parent_zone_id"></a> [parent\_zone\_id](#input\_parent\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | no |
| <a name="input_private_endpoint_enabled"></a> [private\_endpoint\_enabled](#input\_private\_endpoint\_enabled) | Private endpoint allow to connect between 2 aws accounts by private network no need to use internet. To use this feature you need to add payment card to your atlas account | `bool` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region to deploy to | `string` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | A list of domains that should be SANs in the issued certificate | `list(string)` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_url"></a> [client\_url](#output\_client\_url) | Client url |
| <a name="output_server_url"></a> [server\_url](#output\_server\_url) | Server api url |
<!-- END_TF_DOCS -->