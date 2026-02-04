include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else already has the lock
  extra_arguments "backend_config" {
    commands = [
      "init"
    ]

    arguments = [
      "-backend-config=address=${get_env("CI_API_V4_URL")}/projects/${get_env("CI_PROJECT_ID")}/terraform/state/abanca-mistral-la-plateforme-${get_env("CI_ENVIRONMENT_NAME")}",
      "-backend-config=lock_address=${get_env("CI_API_V4_URL")}/projects/${get_env("CI_PROJECT_ID")}/terraform/state/abanca-mistral-la-plateforme-${get_env("CI_ENVIRONMENT_NAME")}/lock",
      "-backend-config=unlock_address=${get_env("CI_API_V4_URL")}/projects/${get_env("CI_PROJECT_ID")}/terraform/state/abanca-mistral-la-plateforme-${get_env("CI_ENVIRONMENT_NAME")}/lock",
      "-backend-config=username=CICDManageTerraformStateToken",
      "-backend-config=password=${get_env("TERRAFORM_STATE_TOKEN")}", 
      "-backend-config=lock_method=POST", 
      "-backend-config=unlock_method=DELETE",
      "-backend-config=retry_wait_min=5",
    ]
    
  }



  extra_arguments "custom_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]

    required_var_files = [ "configs/${get_env("ENVIRONMENT_CONFIG")}/values.tfvars"  ] 
  }
}


inputs = {
  terraform_project_email = get_env("TERRAFORM_PROJECT_EMAIL"),
  iam_service_account_email = get_env("GKE_SA_EMAIL"),
  iam_service_account_creds = get_env("GKE_SA_KEY")
}
