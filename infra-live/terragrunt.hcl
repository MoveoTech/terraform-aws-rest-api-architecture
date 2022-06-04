remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-aws-rest-api-architecture-s3"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-3"
    encrypt = true
    dynamodb_table = "terraform-app-lock-table"
  }
}