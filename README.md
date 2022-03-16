This project goal is to make the developer's life easier from the perspective of repetitive tasks and DevOps tasks.
When using this project you will be able to create AWS Infrastructure to REST API application, both server, and client.
This project use [terraform](https://www.terraform.io/) to automate the process of creating and maintaining the infrastructure.

# Intro


1. **Application** - 
     * Server example app includes connection to DB with user&password.
     * Client example app includes Sign in with MFA, Read/Write events to server API.
2. **Certificate** - Both the server and the client can use a custom domain.
3. **Authentication** - Cognito implementation for user management.
4. **Mongodb** - Creation of infrastructure for DB and connect by PrivateLink to AWS infrastructure.
5. **Turrgrant** - Easy way to duplicate infrastructure for multiple environments. 
6. **CI/CD** - Auto deployment process by code pipeline. 
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
Installation Docs ([link](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started))

First, install the HashiCorp tap, a repository of all our Homebrew packages.

```
brew tap hashicorp/tap
```


Now, install Terraform with `hashicorp/tap/terraform`.

```
brew install hashicorp/tap/terraform
```


Terragrunt installation
---
Installation Docs [link](https://terragrunt.gruntwork.io/docs/getting-started/install/)


```
brew install terragrunt
```

# Installation