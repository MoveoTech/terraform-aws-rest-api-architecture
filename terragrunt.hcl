remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "eliran-terraform-s3"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    dynamodb_table = "multicontainer-todo-app-lock-table"
  }
}