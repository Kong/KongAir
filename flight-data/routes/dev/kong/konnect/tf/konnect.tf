terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
      version = "0.6.0"
    }
  }
}

provider "konnect" {
  server_url = "https://us.api.konghq.com"
}
