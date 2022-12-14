data "aws_secretsmanager_secret" "secrets" {
  name = "project_keys"
}

data "aws_secretsmanager_secret_version" "secrets-keys-values" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

resource "aws_amplify_app" "app_name" {
  name                        = var.name
  repository                  = var.client_repository_name
  access_token                = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.secrets-keys-values.secret_string).github_personal_access_token)
  enable_auto_branch_creation = var.enable_auto_branch_creation
  auto_branch_creation_config {
    # Enable auto build for the created branch.
    enable_auto_build = var.enable_auto_build
  }

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - npm install
        build:
          commands:
            - npm run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  # The default rewrites and redirects added by the Amplify Console.
  custom_rule {
    source = "/<*>"
    status = "404"
    target = "/index.html"
  }
  environment_variables = {
    GITHUB_PERSONAL_ACCESS_TOKEN = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.secrets-keys-values.secret_string).github_personal_access_token)
    NEXT_PUBLIC_BASE_URL         = var.next_public_base_url
    NEXT_PUBLIC_GOOGLE_MAP_KEY   = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.secrets-keys-values.secret_string).next_public_google_map_key)
  }
}

resource "aws_amplify_branch" "develop" {
  app_id            = aws_amplify_app.app_name.id
  branch_name       = var.branch
  framework         = "React"
  stage             = contains(["PRODUCTION", "BETA", "DEVELOPMENT", "EXPERIMENTAL", "PULL_REQUEST"], upper(var.branch)) ? upper(var.branch) : "DEVELOPMENT"
  enable_auto_build = true
}