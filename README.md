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




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="region"></a> [region](#region) | aws region to deploy to | `string` | `eu-west-3` | no |
| <a name="stage"></a> [stage](#stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | null | no |
| <a name="name"></a> [name](#name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'. This is the only ID element not also included as a `tag`. The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | null | no |
| <a name="parent_zone_id"></a> [parent\_zone\_id](#parent\_zone\_id) | The id of the parent Route53 zone to use for the distribution. | `string` | null | no |
| <a name="domain_name"></a> [domain\_name](#domain\_name) | A domain name for which the certificate should be issued | `string` | null | no |
| <a name="aliases_client"></a> [aliases\_client](#aliases\_client) | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | `list(string)` | `[]` | no |
| <a name="aliases_server"></a> [aliases\_server](#aliases\_server) | List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront | `list(string)` | `[]` | no |
| <a name="dns_alias_enabled"></a> [dns\_alias\_enabled](#dns\_alias\_enabled) | Create a DNS alias for the CDN. Requires `parent_zone_id` or `parent_zone_name` | `bool` | false | no |
| <a name="subject_alternative_names"></a> [subject\_alternative\_names](#subject\_alternative\_names) | A list of domains that should be SANs in the issued certificate | `list(string)` | `[]` | no |
| <a name="instance_type"></a> [instance\_type](#instance\_type) | Elastic Beanstalk Instances type | `string` | `t3.micro` | no |
| <a name="availability_zones"></a> [availability\_zones](#availability\_zones) | List of availability zones for the selected region ex: `eu-west-3a`, `eu-west-3b`,`eu-west-3c` | `list(string)` | `["eu-west-3a"]` | no |
| <a name="public_key"></a> [public\_key](#public\_key) | The public API key for MongoDB Atlas | `string` |  | yes |
| <a name="private_key"></a> [private\_key](#private\_key) | The private API key for MongoDB Atlas | `string` |  | yes |
| <a name="atlas_org_id"></a> [atlas\_org\_id](#atlas\_org\_id) | The ID of your MongoDB Atlas organization | `string` |  | yes |
| <a name="client_callback_urls"></a> [client\_callback\_urls](#client\_callback\_urls) | List of allowed callback URLs for the identity providers | `list(string)` | `["http://localhost:3000"]`| no |
| <a name="client_default_redirect_uri"></a> [client\_default\_redirect\_uri](#client\_default\_redirect\_uri) | The default redirect URI. Must be in the list of callback URLs | `string` | null| no |
| <a name="client_logout_urls"></a> [client\_logout\_urls](#client\_logout\_urls) | List of allowed logout URLs for the identity providers | `list(string)` | `[]` | no |
| <a name="github_secret_name"></a> [github\_secret\_name](#github\_secret\_name) | Github secret name for the AWS Secret Manager | `string` | `github_secret` | no |
| <a name="github_org"></a> [github\_org](#github\_org) | Github organization name| `string` |  | yes |
| <a name="client_repository_name"></a> [client\_repository\_name](#client\_repository\_name) | Repository name for the client code | `string` |  | yes |
| <a name="client_branch_name"></a> [client\_branch\_name](#client\_branch\_name) | Branch name for the client code `master` | `string` |  | yes |
| <a name="server_repository_name"></a> [server\_repository\_name](#server\_repository\_name) | Repository name for the server code | `string` |  | yes |
| <a name="client_branch_name"></a> [server\_branch\_name](#server\_branch\_name) | Branch name for the server code `master` | `string` |  | yes |
| <a name="cognito_default_user_email"></a> [cognito\_default\_user\_email](#cognito\_default\_user\_email) | This is a default user to be able to login to the system | `string` |  | yes |
| <a name="private_endpoint_enabled"></a> [private\_endpoint\_enabled](#private\_endpoint\_enabled) | Private endpoint allow to connect between 2 aws accounts by private network no need to use internet. To use this feature you need to add payment card to your atlas account | `bool` | `true` | no |
| <a name="enable_atlas_whitelist_ips"></a> [enable\_atlas\_whitelist\_ips](#enable\_atlas\_whitelist\_ips) | Enable the whitelist ip, if it enabled the ip's taken from the AWS EIP | `bool` | `false` | no |
| <a name="atlas_whitelist_ips"></a> [atlas\_whitelist\_ips](#atlas\_whitelist\_ips) | Enable the whitelist ip, if it enabled the ip's taken from the AWS EIP | `list(string)` | `[]` | no |