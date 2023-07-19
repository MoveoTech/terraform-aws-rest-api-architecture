locals{

    # Context detilas
    region="eu-west-3"
    stage="develop"

    # Cognito detilas
    cognito_default_user_email = "dev@moveohls.com"

    # Database details
    atlas_users =["dev@moveohls.com"]
    mongo_db_major_version = "6.0"

    # Github details
    client_branch_name = "master"
    server_branch_name = "master"
}