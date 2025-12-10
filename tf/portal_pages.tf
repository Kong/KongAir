# Portal Pages Configuration
# Converted from: cfg/portal/portal.yaml (pages section)

# Home Page
resource "konnect_portal_page" "kongair_home" {
  portal_id   = konnect_portal.kongair_portal.id
  slug        = "/"
  title       = "KongAir APIs"
  description = "Build travel experiences powered by real-time schedules, inventory, and customer insights."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/pages/home.md")
}

# APIs Page
resource "konnect_portal_page" "kongair_apis" {
  portal_id   = konnect_portal.kongair_portal.id
  slug        = "apis"
  title       = "API Catalog"
  description = "Discover KongAir services, explore capabilities, and download specs."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/pages/apis.md")
}

# Getting Started Page
resource "konnect_portal_page" "kongair_getting_started" {
  portal_id   = konnect_portal.kongair_portal.id
  slug        = "getting-started"
  title       = "Getting Started"
  description = "Learn how to authenticate, call sandbox endpoints, and move to production."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/pages/getting-started.md")
}

# Guides Page (Parent)
resource "konnect_portal_page" "kongair_guides" {
  portal_id   = konnect_portal.kongair_portal.id
  slug        = "guides"
  title       = "Implementation Guides"
  description = "Step-by-step instructions for combining KongAir APIs in real travel flows."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/pages/guides.md")
}

# Guide: Flight Operations (Child of Guides)
resource "konnect_portal_page" "kongair_guide_flight_operations" {
  portal_id      = konnect_portal.kongair_portal.id
  slug           = "flight-operations"
  title          = "Flight Operations"
  description    = "Create schedule-aware experiences with the Flights and Routes APIs."
  visibility     = "public"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/pages/guides/flight-operations.md")
  parent_page_id = konnect_portal_page.kongair_guides.id
}

# Guide: Booking Automation (Child of Guides)
resource "konnect_portal_page" "kongair_guide_booking_automation" {
  portal_id      = konnect_portal.kongair_portal.id
  slug           = "booking-automation"
  title          = "Booking Automation"
  description    = "Streamline booking flows, confirmations, and updates."
  visibility     = "public"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/pages/guides/manage-bookings.md")
  parent_page_id = konnect_portal_page.kongair_guides.id
}

# Guide: Real-time Booking Updates (Child of Booking Automation)
resource "konnect_portal_page" "kongair_guide_booking_notifications" {
  portal_id      = konnect_portal.kongair_portal.id
  slug           = "real-time-updates"
  title          = "Real-time Booking Updates"
  description    = "Trigger downstream systems when bookings change."
  visibility     = "public"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/pages/guides/manage-bookings/real-time-updates.md")
  parent_page_id = konnect_portal_page.kongair_guide_booking_automation.id
}

# Guide: Customer 360 (Child of Guides)
resource "konnect_portal_page" "kongair_guide_customer_360" {
  portal_id      = konnect_portal.kongair_portal.id
  slug           = "customer-360"
  title          = "Customer 360"
  description    = "Combine booking and customer data for personalized travel experiences."
  visibility     = "public"
  status         = "published"
  content        = file("${path.module}/../cfg/portal/pages/guides/customer-360.md")
  parent_page_id = konnect_portal_page.kongair_guides.id
}
