terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30.0"
    }
  }
}

locals {
  pvc_name = "mai-suite-shared"
}

resource "google_filestore_instance" "main" {
  project  = var.project_id
  location = var.region
  name     = var.name
  tier     = var.tier
  protocol = var.protocol
  file_shares {
    name        = "vol1"
    capacity_gb = 2560
    nfs_export_options {
      ip_ranges   = ["10.0.0.0/24"]
      access_mode = "READ_WRITE"
      squash_mode = "NO_ROOT_SQUASH"
    }
  }
  networks {
    network = var.vpc_name
    modes   = ["MODE_IPV4"]
  }
  kms_key_name = var.kms_crypto_key_id
}

resource "google_kms_crypto_key_iam_member" "main" {
  crypto_key_id = var.kms_crypto_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${var.service_account_email}"
}
