# Portal Snippets Configuration
# Converted from: cfg/portal/portal.yaml (snippets section)

# KongAir Hero Snippet
resource "konnect_portal_snippet" "kongair_hero" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-hero"
  title       = "KongAir Hero"
  description = "Hero section used on the home page."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-hero.md")
}

# KongAir Hero Illustration Snippet
resource "konnect_portal_snippet" "kongair_hero_illustration" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-hero-illustration"
  title       = "KongAir Hero Illustration"
  description = "Primary aircraft illustration displayed in the hero."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-hero-image.md")
}

# Partner Logos Snippet
resource "konnect_portal_snippet" "kongair_logo_bar" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-logo-bar"
  title       = "Partner Logos"
  description = "Sample airline partner strip."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-logo-bar.md")
}

# Destination Art Snippet
resource "konnect_portal_snippet" "kongair_destination_art" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-destination-art"
  title       = "Destination Route Illustration"
  description = "Supplemental route map art for portal pages."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-destination-art.md")
}

# Page Navigation Snippet
resource "konnect_portal_snippet" "kongair_page_nav" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-page-nav"
  title       = "Guide Navigation"
  description = "Reusable navigation block for guide pages."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-page-nav.md")
}

# Table of Contents Snippet
resource "konnect_portal_snippet" "kongair_page_toc" {
  portal_id   = konnect_portal.kongair_portal.id
  name        = "kongair-page-toc"
  title       = "On This Page"
  description = "Table of contents helper for long-form articles."
  visibility  = "public"
  status      = "published"
  content     = file("${path.module}/../cfg/portal/snippets/kongair-page-toc.md")
}
