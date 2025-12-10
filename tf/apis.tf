# API Configuration

# Flights API
resource "konnect_api" "kongair_flights" {
  name        = "Flights Service"
  description = "KongAir Flights service provides the scheduled flights for KongAir"
  slug        = "flights"

  labels = {
    domain   = "flight-data"
    product  = "operations"
    protocol = "rest"
  }
}

# Flights API Product Version
resource "konnect_api_version" "kongair_flights_ver" {
  api_id = konnect_api.kongair_flights.id
  spec = {
    content = "{\"openapi\":\"3.0.3\",\"info\":{\"title\":\"Example API\",\"version\":\"1.0.0\"},\"paths\":{\"/example\":{\"get\":{\"summary\":\"Example endpoint\",\"responses\":{\"200\":{\"description\":\"Successful response\"}}}}}}"
  }
  version = "1.0.0"
}

# Flights API Product Documents
resource "konnect_api_document" "kongair_flights_overview" {
  api_id = konnect_api.kongair_flights.id
  title          = "Flights API: Getting Started"
  slug           = "flights-getting-started"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/apis/flights/docs/getting-started.md")
}

resource "konnect_api_document" "kongair_flights_query_reference" {
  api_id = konnect_api.kongair_flights.id
  title          = "Flights API: Query Patterns"
  slug           = "flights-query-patterns"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/apis/flights/docs/query-reference.md")
}

resource "konnect_api_document" "kongair_flights_data_model" {
  api_id = konnect_api.kongair_flights.id
  title          = "Flights API: Data Model"
  slug           = "flights-data-model"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/apis/flights/docs/data-model.md")
}
