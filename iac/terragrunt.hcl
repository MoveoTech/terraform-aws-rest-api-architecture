remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "moveo-terraform-s3"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    dynamodb_table = "terraform-app-lock-table"
  }
}