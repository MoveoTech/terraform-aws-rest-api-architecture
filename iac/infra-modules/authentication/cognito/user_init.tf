data "template_file" "application_bootstrap" {
  template = file("${path.module}/cf_template.json")

  vars = {
    user_pool_id          = module.aws_cognito_user_pool.id
    users_mail            = var.cognito_default_user_email
  }
}

resource "aws_cloudformation_stack" "test_users" {
  name = "create-test-users"

  template_body = data.template_file.application_bootstrap.rendered
}