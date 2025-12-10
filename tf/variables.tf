# Variables for Kong Konnect Terraform Configuration

variable "control_plane_name" {
  description = "Name of the existing Kong control plane"
  type        = string
  default     = "kongair"
}

variable "gateway_service_name" {
  description = "Name of the existing Kong gateway service"
  type        = string
  default     = "kongair-api"
}

variable "portal_primary_color" {
  description = "Primary color for the portal theme"
  type        = string
  default     = "#0B5F9E"
}

# Note: These variables are optional and can be used to make the configuration
# more flexible. The current configuration uses hardcoded values for simplicity,
# but you can update the resource definitions to use these variables instead.
