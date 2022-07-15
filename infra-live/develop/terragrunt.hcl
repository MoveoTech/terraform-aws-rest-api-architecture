inputs = {
  region                     = "eu-west-3"
  availability_zones         = ["eu-west-3a"]
  stage                      = "develop"
  name                       = "terraform-moveohls"
  cognito_default_user_email = "eliran@moveohls.com"
  client_repository_name     = "terraform-aws-rest-api-architecture"
  client_branch_name         = "main"
  server_repository_name     = "terraform-aws-rest-api-architecture"
  server_branch_name         = "main"
  github_org                 = "MoveoTech"
  private_endpoint_enabled   = false
  enable_atlas_whitelist_ips  =true
  provider_instance_size_name ="M10"
  server_buildspec_path = "apps/server/buildspec.yml"
  client_buildspec_path = "apps/client/buildspec.yml"
}

include {
  # The find_in_parent_folders() helper will 
  # automatically search up the directory tree to find the root terragrunt.hcl and inherit 
  # the remote_state configuration from it.
  path = find_in_parent_folders()
}

terraform {
  source = "../../examples/simple"

  extra_arguments "conditional_vars" {
    # built-in function to automatically get the list of 
    # all commands that accept -var-file and -var arguments
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-lock-timeout=10m"
    ]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/sensitive.tfvars"
    ]
  }
}
