provider "google" {
 alias            = "principal"
 project 		      = var.seed_project_id
 credentials	    = file(var.gcp_credentials_file)
 request_timeout 	= "60s"
}

provider "google" {
 alias = "impersonation"
 scopes = [
   "https://www.googleapis.com/auth/cloud-platform",
   "https://www.googleapis.com/auth/userinfo.email",
 ]
}

provider "google" {
 project 		      = var.seed_project_id
 access_token	    = data.google_service_account_access_token.terraform.access_token
 request_timeout 	= "60s"
}

provider "google-beta" {
  access_token	  = data.google_service_account_access_token.terraform.access_token
  request_timeout = "5m"
}

provider "random" {
  # Configuration options.
}
