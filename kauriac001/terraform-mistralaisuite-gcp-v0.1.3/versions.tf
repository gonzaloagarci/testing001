terraform {
  required_version = "~> 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30.0"
    }
  }
}

# provider "google" {
#   default_labels = var.default_labels
#   project        = var.project_id
#   region         = var.region
# }

# data "google_client_config" "main" {
#   depends_on = [ module.cluster ]
# }

# data "google_service_account_access_token" "main" {
#   target_service_account = "gc-sa-xxt-kaur-mistral@gc-pr-xxt-7765-kaur-mistral.iam.gserviceaccount.com"
#   scopes                = ["https://www.googleapis.com/auth/cloud-platform"]
#   lifetime               = "3600s"
# }


provider "kubernetes" {
  host                   = var.cluster_create ? try("https://${module.cluster[0].dns_endpoint}", null) : null
  cluster_ca_certificate = var.cluster_create ? try(base64decode(module.cluster[0].cluster_ca_certificate), null) : null

  dynamic "exec" {
    for_each = var.cluster_create ? [1] : []
    content {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "gcloud"
  #   args = [
  #     "auth",
  #     "print-access-token", "--impersonate-service-account", "gc-sa-xxt-kaur-mistral@gc-pr-xxt-7765-kaur-mistral.iam.gserviceaccount.com"
  #   ]
  #   # args = [
  #   #   "container",
  #   #   "clusters",
  #   #   "get-credentials",
  #   #   "mistral-ai-suite-va1bd88q-cluster",
  #   #   "--region",
  #   #   "europe-southwest1",
  #   #   "--project",
  #   #   "gc-pr-xxt-7765-kaur-mistral",
  #   #   "--dns-endpoint",
  #   #   "--impersonate-service-account",
  #   #   "gc-sa-xxt-kaur-mistral@gc-pr-xxt-7765-kaur-mistral.iam.gserviceaccount.com"
  #   # ]
  # }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_create ? try("https://${module.cluster[0].dns_endpoint}", null) : null
    cluster_ca_certificate = var.cluster_create ? try(base64decode(module.cluster[0].cluster_ca_certificate), null) : null

    dynamic "exec" {
      for_each = var.cluster_create ? [1] : []
      content {
        api_version = "client.authentication.k8s.io/v1beta1"
        command     = "gke-gcloud-auth-plugin"
      }
    }

    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   command     = "gcloud"
    #   # args = [
    #   #   "auth",
    #   #   "print-access-token", "--impersonate-service-account", "gc-sa-xxt-kaur-mistral@gc-pr-xxt-7765-kaur-mistral.iam.gserviceaccount.com"
    #   # ]
    #   # args = [
    #   #   "container",
    #   #   "clusters",
    #   #   "get-credentials",
    #   #   "mistral-ai-suite-va1bd88q-cluster",
    #   #   "--region",
    #   #   "europe-southwest1",
    #   #   "--project",
    #   #   "gc-pr-xxt-7765-kaur-mistral",
    #   #   "--dns-endpoint",
    #   #   "--impersonate-service-account",
    #   #   "gc-sa-xxt-kaur-mistral@gc-pr-xxt-7765-kaur-mistral.iam.gserviceaccount.com"
    #   # ]
    # }
  }
  
}


