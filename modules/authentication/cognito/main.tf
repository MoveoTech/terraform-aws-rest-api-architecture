
resource "aws_cognito_user" "default_user" {
  user_pool_id             = module.aws_cognito_user_pool.id
  username                 = var.cognito_default_user_email
  desired_delivery_mediums = ["EMAIL"]
  attributes = {
    email          = var.cognito_default_user_email
    email_verified = true
  }
}


module "aws_cognito_user_pool" {

  source  = "lgallard/cognito-user-pool/aws"
  version = "0.26.0"

  user_pool_name             = "${var.context.name}-${var.context.stage}${var.user_pool_name}"
  username_attributes        = ["email"]
  auto_verified_attributes   = ["email"]
  sms_authentication_message = "Your username is {username} and temporary password is {####}."
  sms_verification_message   = "This is the verification message {####}."

  mfa_configuration = "ON"
  software_token_mfa_configuration = {
    enabled = true
  }

  admin_create_user_config = var.admin_create_user_config

  device_configuration = {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = true
  }

  username_configuration = {
    case_sensitive = false
  }

  password_policy = var.password_policy

  user_pool_add_ons = {
    advanced_security_mode = "ENFORCED"
  }

  verification_message_template = var.verification_message_template

  recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    },
    {
      name     = "verified_phone_number"
      priority = 2
    }
  ]

  schemas = var.schemas

  string_schemas = var.string_schemas

  number_schemas = var.number_schemas


  # user_pool_domain
  domain = "${var.context.name}-${var.context.stage}${var.user_pool_name}${var.domain_name}"
  # clients
  clients = [
    {
      allowed_oauth_flows                  = ["code"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["email", "openid", "profile"]
      prevent_user_existence_errors        = "ENABLED"
      callback_urls                        = var.client_callback_urls
      default_redirect_uri                 = var.client_default_redirect_uri
      explicit_auth_flows                  = var.explicit_auth_flows
      generate_secret                      = var.generate_secret
      logout_urls                          = var.client_logout_urls
      name                                 = "web-app"
      read_attributes                      = concat(["email"], var.client_read_attributes)
      supported_identity_providers         = ["COGNITO"]
      write_attributes                     = var.client_write_attributes
      access_token_validity                = var.clients_access_token_validity_hours_amount
      id_token_validity                    = var.clients_id_token_validity_hours_amount
      refresh_token_validity               = var.clients_refresh_token_validity_hours_amount
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "hours"
      }
    }
  ]

  # tags
  tags = merge(var.context.tags, {
    yor_trace = "e8810cd3-cec1-422e-ab28-baba3b8a858f"
  })
}


