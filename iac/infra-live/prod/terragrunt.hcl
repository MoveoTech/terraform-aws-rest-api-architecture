inputs = {
        region = "eu-west-3"
        availability_zones = ["eu-west-3a","eu-west-3b"]

        instance_type       = "t3.micro"
        stage = "production"
        name = "terraform-moveo"
        cognito_default_user_email = "eliran@moveohls.com"

        ########## Github Vars        ###################
        github_secret_name ="github_secret"
        client_repository_name    = "terraform"
        client_branch_name    = "develop"
        server_repository_name    = "terraform"
        server_branch_name    = "develop"
        github_org = "MoveoTech"
        ########## Github Vars        ###################


        ########## Atlas Vars        ###################
        atlas_users = ["eliran@moveohls.com","eliran@moveo.co.il"]
        private_endpoint_enabled = true
        enable_atlas_whitelist_ips = false
        atlas_whitelist_ips= ["37.46.46.79"]
        ########## Atlas Vars        ###################



        ########## Auth Vars        ###################
          client_logout_urls          = ["http://localhost:3000/logout"]
          client_default_redirect_uri = "http://localhost:3000"
          client_callback_urls        = ["http://localhost:3000"]
        ########## Auth Vars        ###################



        ########## Certificate Vars ###################

        parent_zone_id = "ZZG2X8KI3MIQB"
        aliases_client =["prod.terraform.moveodevelop.com", "www.prod.terraform.moveodevelop.com"]
        domain_name                       = "prod.terraform.moveodevelop.com"
        subject_alternative_names         = ["www.prod.terraform.moveodevelop.com"]
        dns_alias_enabled= true

        ########## Certificate Vars ###################


}

include {
  # The find_in_parent_folders() helper will 
  # automatically search up the directory tree to find the root terragrunt.hcl and inherit 
  # the remote_state configuration from it.
  path = find_in_parent_folders()
}

terraform {
  source = "../../infra-modules"

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
