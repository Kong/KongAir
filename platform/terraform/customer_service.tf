resource "konnect_gateway_control_plane" "customer_service_control_plane" {
  name         = "Customer Service Control Plane"
  description  = "Customer Service Business Domain"
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"
  auth_type    = "pinned_client_certs"
  cloud_gateway = false
}

resource "konnect_team" "customer_service_team" {
  name        = "Customer Service Team"
  description = "Customer Service Team managed by Terraform"

  labels = {
    example = "here"
  }
}

resource "konnect_team_role" "customer_service_team_cp_role" {
  entity_id        = konnect_gateway_control_plane.customer_service_control_plane.id
  entity_region    = "eu"
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.customer_service_team.id
}