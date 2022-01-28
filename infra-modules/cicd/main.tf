# GitHub secrets
data "aws_secretsmanager_secret" "github_secret" {
  name = var.github_secret_name
}

data "aws_secretsmanager_secret_version" "github_token" {
  secret_id = data.aws_secretsmanager_secret.github_secret.id
}

# Codebuild module for CI
module "codebuild_application" {
  source = "./codebuild"
  name = "codebuild-app"
  image       = "aws/codebuild/standard:4.0"
  environment     = var.environment
}

# CodePipeline module for CICD pipeline
module "codepipeline_for_multicontainer_app" {
  source = "./codepipeline"
  name = "codepipeline-app"
  bucket_name = var.bucket_name
  github_org = var.github_org
  repository_name = var.repository_name
  branch_name = var.branch_name
  environment     = var.environment
  region = var.region
  project_name = module.codebuild_application.project_name
  github_token = jsondecode(data.aws_secretsmanager_secret_version.github_token.secret_string)["GitHubPersonalAccessToken"]
}


# Cloudwatch event module for pipeline state changes
module "cloudwatch_for_pipeline_notifications" {
  source = "./cloudwatch"
  name = "multicontainer-pipeline-state-change"
  description = "event for multicontainer app pipeline state change"
  role_name = "cloudwatch-for-multicontainer-pipeline-role"
  policy_name = "cloudwatch-for-multicontainer-pipeline-policy"
  targetId = "SendToLambda"
  codepipeline_arn = module.codepipeline_for_multicontainer_app.arn
  codepipeline_name = module.codepipeline_for_multicontainer_app.name
  resource_arn = module.lambda_for_pipeline_notifications.arn
  environment = var.environment
}

# Lambda module for pushing pipeline state change notifications to Slack
module "lambda_for_pipeline_notifications" {
  source = "./lambda"
  function_name = "lambda-push-pipeline-notification-to-slack"
  source_arn = module.cloudwatch_for_pipeline_notifications.arn
  lambda_role = "lambda-for-multicontainer-pipeline-role"
  lambda_policy = "lambda-for-multicontainer-pipeline-policy"
  environment = var.environment
}