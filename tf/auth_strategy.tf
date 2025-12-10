# Application Authentication Strategy
# Converted from: cfg/portal/app-auth-strategy.yaml

resource "konnect_application_auth_strategy" "kongair_apikey_strategy" {
  key_auth = {
    name          = "kongair-api-key-strat"
    display_name  = "Kong Air API Key Authentication"
    strategy_type = "key_auth"

    configs = {
      key_auth = {
        key_names = [
          "X-API-Key",
          "Api-Key"
        ]
      }
    }
  }
}
