
inputs = {
  gitlab_access_token = get_env("TERRAFORM_STATE_TOKEN")
  gitlab_username = "CICDManageTerraformStateToken"
  gcp_credentials_file = get_env("GOOGLE_CREDENTIALS_PATH") 
}
