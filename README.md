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
Default output format [None]: json

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


![image description](./secret-manager.png)


In the secret key use the same key: `GitHubPersonalAccessToken`

And the value will be your key you generated from Github.

![image description](./secrets-value.png)

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
  source = "../../infra-modules"

  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "< PROVIDE YOUR EMAIL >"
  client_repository_name     = "terraform"
  client_branch_name         = "develop"
  server_repository_name     = "terraform"
  server_branch_name         = "develop"
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
  source                     = "../../infra-modules"
  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  instance_type              = "t3.micro"
  stage                      = "test"
  name                       = "terraform-moveo"
  cognito_default_user_email = "dev@moveohls.com"
  client_repository_name     = "terraform"
  client_branch_name         = "develop"
  server_repository_name     = "terraform"
  server_branch_name         = "develop"
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