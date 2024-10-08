resource "konnect_gateway_control_plane" "commercial_ops_control_plane" {
  name         = "Commercial Operations Control Plane"
  description  = "commercial Operations Business Domain"
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"
  auth_type    = "pinned_client_certs"
  cloud_gateway = false
}

output "commercial_ops_control_plane_id" {
  value = konnect_gateway_control_plane.commercial_ops_control_plane.id
}

resource "konnect_team" "commercial_ops_team" {
  name        = "Commercial Operations Team"
  description = "Commercial Operations Team managed by Terraform"

  labels = {
    example = "here"
  }
}

resource "konnect_team_role" "commercial_ops_team_cp_role" {
  entity_id        = konnect_gateway_control_plane.commercial_ops_control_plane.id
  entity_region    = "eu"
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.commercial_ops_team.id
}