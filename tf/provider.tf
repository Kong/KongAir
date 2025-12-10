terraform {
  required_providers {
    konnect = {
      source  = "kong/konnect"
      version = "~> 3.2.1"
    }
  }
}

provider "konnect" {
  # Configure authentication via the KONNECT_TOKEN environment variable:
  # export KONNECT_TOKEN="your-personal-access-token"

  # Optionally override the server URL (defaults to https://global.api.konghq.com)
  # server_url = "https://global.api.konghq.com"
}
