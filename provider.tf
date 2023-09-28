terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.84.0"
    }
  }
}

provider "google" {

  project = var.PROJECT_ID
  region  = var.REGION
}