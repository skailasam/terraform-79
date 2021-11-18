terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
#      version = "3.52.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    helm = {
      source = "hashicorp/helm"
    }
  }

  required_version = "~> 1.0.11"
}

