
locals{
    
    # Project name. 
    name="terragrunt-modules-hls"

    # build spec files
    server_buildspec_path = "apps/server/buildspec.yml"
    client_buildspec_path = "apps/client/buildspec.yml"
    client_env_prefix = "NX"

    # Github details
    github_org = "MoveoTech"
    server_repository_name="node-monorepo"
    client_repository_name="node-monorepo"
}