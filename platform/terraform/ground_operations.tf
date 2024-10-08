resource "konnect_gateway_control_plane" "ground_ops_control_plane" {
  name         = "Ground Operations Control Plane"
  description  = "Ground Operations Business Domain"
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"
  auth_type    = "pinned_client_certs"
  cloud_gateway = true
}

resource "konnect_team" "ground_ops_team" {
  name        = "Ground Operations Team"
  description = "Ground Operations Team managed by Terraform"

  labels = {
    example = "here"
  }
}

resource "konnect_team_role" "ground_ops_team_cp_role" {
  entity_id        = konnect_gateway_control_plane.ground_ops_control_plane.id
  entity_region    = "eu"
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.ground_ops_team.id
}