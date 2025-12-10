# Outputs for Kong Konnect Terraform Configuration

# Portal Outputs
output "portal_id" {
  description = "The ID of the KongAir portal"
  value       = konnect_portal.kongair_portal.id
}

output "portal_name" {
  description = "The name of the KongAir portal"
  value       = konnect_portal.kongair_portal.name
}

output "portal_canonical_domain" {
  description = "The canonical domain of the KongAir portal"
  value       = konnect_portal.kongair_portal.canonical_domain
}

output "portal_default_domain" {
  description = "The default domain of the KongAir portal"
  value       = konnect_portal.kongair_portal.default_domain
}

# API Product Outputs
output "flights_api_id" {
  description = "The ID of the Flights API"
  value       = konnect_api.kongair_flights.id
}

output "flights_api_version_id" {
  description = "The ID of the Flights API version"
  value       = konnect_api_version.kongair_flights_ver.id
}

# Auth Strategy Outputs
output "api_key_auth_strategy_id" {
  description = "The ID of the API Key authentication strategy"
  value       = konnect_application_auth_strategy.kongair_apikey_strategy.key_auth.id
}

# Control Plane Outputs
output "control_plane_id" {
  description = "The ID of the referenced control plane"
  value       = data.konnect_gateway_control_plane.kongair_cp.id
}

# Uncomment once gateway service data source is configured
# output "gateway_service_id" {
#   description = "The ID of the referenced gateway service"
#   value       = data.konnect_gateway_service.kongair_gw_svc.id
# }
