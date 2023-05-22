provider "aws" {
  region = "us-east-1"
}


module "context" {
  source = "../../modules/context"
}


module "cognito_auth" {
  source                      = "../../modules/authentication/cognito"
  client_logout_urls          = ["https://logout.com"]
  client_default_redirect_uri = "https://redirecturi.com"
  client_callback_urls        = ["https://callbackurl.com"]
  cognito_default_user_email  = "default@gmail.com"
  context                     = module.context
}
