inputs = {
  environment    = "prod"
  branch_name    = "master"
  github_org = "MoveoTech"
  profile = "default"
  region = "eu-north-1"
  app_port = 3000
  availability_zones = ["eu-north-1a","eu-north-1b","eu-north-1c"]
  main_pvt_route_table_id ="rtb-0b7b7dbf9078301f1"
  bucket_name = "terraform-moveo-test"
  github_secret_name = "github_secret"
  repository_name = "Skill-Epicure-Dan"
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = "64bit Amazon Linux 2 v5.4.9 running Node.js 14"
  instance_type       = "t3.micro"
  app_name            = "myapp"
  platform_name       = "eliran-eb"
  namespace = "eg"
  stage = "test"
  name = "vpc-subnets"
}

include {
  # The find_in_parent_folders() helper will 
  # automatically search up the directory tree to find the root terragrunt.hcl and inherit 
  # the remote_state configuration from it.
  path = find_in_parent_folders()
}

terraform {
  source = "../../infra-modules/backend"

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
