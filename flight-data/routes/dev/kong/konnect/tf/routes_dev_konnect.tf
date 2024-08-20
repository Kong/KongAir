
locals {
  common_labels = {
    team = "flight-data"
    svc = "routes"
    env = "dev"
  }
}

resource "random_id" "id" {
	  byte_length = 4
}

resource "konnect_gateway_control_plane" "routes_dev" {
  name         = "KongAir-DEV-routes-team-${random_id.id.hex}"
  description  = "Temporary Gateway for Routes service testing"
  cluster_type = "CLUSTER_TYPE_SERVERLESS"
  auth_type    = "pinned_client_certs"
  labels       = local.common_labels
}

resource "konnect_gateway_data_plane_client_certificate" "routes_cert" {
  cert             = file("./tls.crt")
  control_plane_id = konnect_gateway_control_plane.routes_dev.id
}

resource "konnect_serverless_cloud_gateway" "routes_gateway" {
  control_plane = {
    id     = konnect_gateway_control_plane.routes_dev.id
    prefix = replace(replace(konnect_gateway_control_plane.routes_dev.config.control_plane_endpoint, "https://", ""), ".us.cp0.konghq.com", "")
    region = "us"
  }
  cluster_cert     = file("./tls.crt")
  cluster_cert_key = file("./tls.key")
  labels = local.common_labels
}

output "gateway_endpoint" {
  value = konnect_serverless_cloud_gateway.routes_gateway.gateway_endpoint
}
output "control_plane_name" {
  value = konnect_gateway_control_plane.routes_dev.name
}
