resource "konnect_gateway_control_plane" "maintenance_control_plane" {
  name         = "Maintenance, Repair & Overhaul Control Plane"
  description  = "Maintenance, Repair & Overhaul Business Domain"
  cluster_type = "CLUSTER_TYPE_K8S_INGRESS_CONTROLLER"
  auth_type    = "pinned_client_certs"
  cloud_gateway = false
}

resource "konnect_team" "maintenance_team" {
  name        = "Maintenance, Repair & Overhaul Team"
  description = "Maintenance, Repair & Overhaul Team managed by Terraform"

  labels = {
    example = "here"
  }
}

resource "konnect_team_role" "maintenance_ops_team_cp_role" {
  entity_id        = konnect_gateway_control_plane.maintenance_control_plane.id
  entity_region    = "eu"
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.maintenance_team.id
}