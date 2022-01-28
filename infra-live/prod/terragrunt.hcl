inputs = {
  environment    = "prod"
  branch_name    = "master"
  github_org = "MoveoTech"
  profile = "default"
  region = "eu-west-2"
  bucket_name = "terraform-moveo-test"
  github_secret_name = "github_secret"
  repository_name = "Skill-Epicure-Dan"

}

include {
  # The find_in_parent_folders() helper will 
  # automatically search up the directory tree to find the root terragrunt.hcl and inherit 
  # the remote_state configuration from it.
  path = find_in_parent_folders()
}

terraform {
  source = "../../infra-modules/cicd"

  extra_arguments "conditional_vars" {
    # built-in function to automatically get the list of 
    # all commands that accept -var-file and -var arguments
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-lock-timeout=10m",
      "-var", "module=${path_relative_to_include()}"
    ]

    required_var_files = [
      "${get_parent_terragrunt_dir()}/sensitive.tfvars"
    ]
  }
}
