# Configure the provider to use your Kong Konnect account
terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
      version = "1.0.0"
    }
  }
}

variable "personal_access_token" {
  type      = string
  sensitive = true
}

provider "konnect" {
  personal_access_token = var.personal_access_token
  server_url            = "https://eu.api.konghq.com"
}