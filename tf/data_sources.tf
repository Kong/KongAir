# Data sources for external resources referenced in the kongctl configuration
# These resources already exist and are being referenced by their names

# Reference to existing control plane named "kongair"
data "konnect_gateway_control_plane" "kongair_cp" {
  filter = {
    name = {
      eq = "kongair"
    }
  }
}

# Reference to existing gateway service named "kongair-api"
# Note: The Konnect provider's gateway_service data source may require
# the service ID directly. You have two options:
#
# Option 1: If you know the service ID, use it directly:
# data "konnect_gateway_service" "kongair_gw_svc" {
#   control_plane_id = data.konnect_gateway_control_plane.kongair_cp.id
#   id               = "your-service-id-here"
# }
#
# Option 2: Use a variable or external data source to look it up
# For now, you'll need to either:
# - Manually find the service ID from the Konnect UI
# - Use the Konnect API to find services by name
# - Import this as a managed resource instead of a data source
#
# Placeholder - update with actual service ID:
# data "konnect_gateway_service" "kongair_gw_svc" {
#   control_plane_id = data.konnect_gateway_control_plane.kongair_cp.id
#   id               = var.gateway_service_id
# }
