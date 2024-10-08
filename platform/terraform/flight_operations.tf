resource "konnect_gateway_control_plane" "flight_ops_control_plane" {
  name         = "Flight Operations Control Plane"
  description  = "Flight Operations Business Domain"
  cluster_type = "CLUSTER_TYPE_CONTROL_PLANE"
  auth_type    = "pinned_client_certs"
  cloud_gateway = true
}

output "flight_ops_control_plane_id" {
  value = konnect_gateway_control_plane.flight_ops_control_plane.id
}

data "konnect_cloud_gateway_provider_account_list" "flight_ops_cloudgatewayprovideraccountlist" {
  page_number = 1
  page_size   = 1
}

resource "konnect_cloud_gateway_network" "flight_ops_cloudgatewaynetwork" {
  name   = "Flight Ops AWS Network"
  region = "eu-west-1"
  availability_zones = [
    "euw1-az1",
    "euw1-az2",
    "euw1-az3"
  ]

  firewall = {
    allowed_cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  cidr_block      = "192.168.0.0/16"
  ddos_protection = false

  cloud_gateway_provider_account_id = data.konnect_cloud_gateway_provider_account_list.flight_ops_cloudgatewayprovideraccountlist.data[0].id
}

resource "konnect_cloud_gateway_configuration" "flight_ops_cloudgatewayconfiguration" {
  api_access        = "private+public"
  control_plane_geo = "eu"
  control_plane_id  = konnect_gateway_control_plane.flight_ops_control_plane.id
  dataplane_groups = [
    {
      provider = "aws"
      region   = "eu-west-1"
      autoscale = {
        configuration_data_plane_group_autoscale_autopilot = {
          kind     = "autopilot"
          base_rps = 10
          max_rps  = 100
        }

        #configuration_data_plane_group_autoscale_static = {
        #  kind                = "static"
        #  instance_type       = "small"
        #  requested_instances = 1
        #}
      }
      cloud_gateway_network_id = konnect_cloud_gateway_network.flight_ops_cloudgatewaynetwork.id
    },
  ]
  version = "3.8"
}

resource "konnect_team" "flight_ops_team" {
  name        = "Flight Operations Team"
  description = "Flight Operations Team managed by Terraform"

  labels = {
    example = "here"
  }
}

resource "konnect_team_role" "flight_ops_team_cp_role" {
  entity_id        = konnect_gateway_control_plane.flight_ops_control_plane.id
  entity_region    = "eu"
  entity_type_name = "Control Planes"
  role_name        = "Admin"
  team_id          = konnect_team.flight_ops_team.id
}