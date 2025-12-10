
resource "konnect_api_publication" "kongair_flights_publication" {
  api_id      = konnect_api.kongair_flights.id
  portal_id   = konnect_portal.kongair_portal.id
  visibility  = "public"
}
