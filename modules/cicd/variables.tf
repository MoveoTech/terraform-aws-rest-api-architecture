
variable "client_env_prefix" {
  type = string
  description = "Prefix for react envoiremnt variable, this added for supporting NX prefix"
}
variable "context" {
  type = any
  default = {
    enabled             = true
    namespace           = null
    tenant              = null
    environment         = null
    stage               = null
    name                = null
    delimiter           = null
    attributes          = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = null
    label_key_case      = null
    label_value_case    = null
    descriptor_formats  = {}
    # Note: we have to use [] instead of null for unset lists due to
    # https://github.com/hashicorp/terraform/issues/28137
    # which was not fixed until Terraform 1.0.0,
    # but we want the default to be all the labels in `label_order`
    # and we want users to be able to prevent all tag generation
    # by setting `labels_as_tags` to `[]`, so we need
    # a different sentinel to indicate "default"
    labels_as_tags = ["unset"]
  }
  description = <<-EOT
    Single object for setting entire context at once.
    See description of individual variables for details.
    Leave string and numeric variables as `null` to use default value.
    Individual variable settings (non-null) override settings in context object,
    except for attributes, tags, and additional_tag_map, which are merged.
  EOT

  validation {
    condition     = lookup(var.context, "label_key_case", null) == null ? true : contains(["lower", "title", "upper"], var.context["label_key_case"])
    error_message = "Allowed values: `lower`, `title`, `upper`."
  }

  validation {
    condition     = lookup(var.context, "label_value_case", null) == null ? true : contains(["lower", "title", "upper", "none"], var.context["label_value_case"])
    error_message = "Allowed values: `lower`, `title`, `upper`, `none`."
  }
}
variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "github_secret_name" {
  description = "Secret key name"
  type        = string
  default     = "github_secret"
}

variable "github_org" {
  description = "Github organization name"
  type        = string
}

variable "client_repository_name" {
  description = "Client repository name"
  type        = string
}


variable "client_branch_name" {
  description = "Client branch name"
  type        = string
}

variable "server_repository_name" {
  description = "Server repository name"
  type        = string
}


variable "server_branch_name" {
  description = "Server branch name"
  type        = string
}


variable "elastic_beanstalk_application_name" {
  type        = string
  description = "Elastic beanstalk app name"
}
variable "elastic_beanstalk_environment_name" {
  type        = string
  description = "Elastic beanstalk environment name"
}

variable "client_bucket_name" {
  type        = string
  description = "The bucket where the client files are found"
}
variable "cognito_pool_id" {
  type        = string
  description = "Cognito pool id to configure the authentication"
}
variable "cognito_web_client_id" {
  type        = string
  description = "Cognito web client id to configure the authentication"
}

variable "invoke_url" {
  description = "The URL to invoke the API pointing to the stage, e.g., https://z4675bid1j.execute-api.eu-west-2.amazonaws.com/prod"
  type        = string
}


variable "cf_distribution_id" {
  type        = string
  description = "Cloudfront distribution id"

}

variable "vpc_id" {
  type        = string
  description = "VPC ID where subnets will be created (e.g. `vpc-aceb2723`)"
}


variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of the created private subnets"
}

variable "server_buildspec_path" {
  type        = string
  description = "Full path to the place where the buildspec.yml for server ci"

}
variable "client_buildspec_path" {
  type        = string
  description = "Full path to the place where the buildspec.yml for client ci"
}
