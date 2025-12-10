# Portal Configuration
# Converted from: cfg/portal/portal.yaml

# KongAir Portal
resource "konnect_portal" "kongair_portal" {
  name                                 = "KongAir Portal"
  display_name                         = "KongAir Developer Portal"
  description                          = "Explore KongAir operational APIs for schedules, routes, bookings, and customer accounts."
  authentication_enabled               = false
  rbac_enabled                         = false
  auto_approve_developers              = false
  auto_approve_applications            = false
  default_api_visibility               = "public"
  default_page_visibility              = "public"
  default_application_auth_strategy_id = konnect_application_auth_strategy.kongair_apikey_strategy.key_auth.id
}

# Portal Customization
resource "konnect_portal_customization" "kongair_portal_customization" {
  portal_id        = konnect_portal.kongair_portal.id
  theme       = {
    mode = "system"
  }
}
