# KongAir Portal - Terraform Configuration

This directory contains Terraform configurations for managing the KongAir Developer Portal using the Kong Konnect Terraform provider. These manifests were converted from the kongctl declarative configuration found in the `../cfg/` directory.

## Overview

This Terraform configuration manages:

- **Developer Portal**: Portal configuration with customization and branding
- **API Products**: API product definitions, versions, and specifications
- **Authentication Strategies**: API key authentication for applications
- **Portal Content**: Pages, guides, and reusable snippets
- **Publications**: API product publications to the portal

## Prerequisites

1. **Terraform**: Install Terraform >= 1.0
2. **Kong Konnect Account**: Active Kong Konnect account with appropriate permissions
3. **Authentication Token**: Set the `KONNECT_TOKEN` environment variable with your personal access token

## File Structure

```
tf/
├── provider.tf                 # Terraform and provider configuration
├── data_sources.tf            # Data sources for existing resources
├── auth_strategy.tf           # Application authentication strategies
├── api_products.tf            # API products, versions, specs, and docs
├── portal.tf                  # Portal and appearance configuration
├── portal_pages.tf            # Portal pages and guides
├── portal_snippets.tf         # Reusable content snippets
├── portal_publications.tf     # Portal product version publications
└── README.md                  # This file
```

## Usage

### 1. Set Authentication

Export your Kong Konnect personal access token:

```bash
export KONNECT_TOKEN="your-personal-access-token-here"
```

To create a personal access token:
1. Log in to Kong Konnect
2. Navigate to your account settings
3. Generate a new personal access token
4. Copy and export it as shown above

### 2. Review Data Sources

The configuration references existing resources:
- Control plane named "kongair"
- Gateway service named "kongair-api"

Ensure these resources exist in your Konnect organization, or update `data_sources.tf` accordingly.

### 3. Initialize Terraform

```bash
cd tf
terraform init
```

### 4. Review Plan

```bash
terraform plan
```

### 5. Apply Configuration

```bash
terraform apply
```

## Resource Dependencies

The resources have the following dependency chain:

1. **Data Sources** (existing resources)
   - Control Plane: `kongair`
   - Gateway Service: `kongair-api`

2. **Foundation Resources**
   - Portal (`konnect_portal.kongair_portal`)
   - Auth Strategy (`konnect_application_auth_strategy.kongair_apikey_strategy`)

3. **API Products**
   - API Product (`konnect_api_product.kongair_flights`)
   - API Product Version (`konnect_api_product_version.kongair_flights_v0_1`)
   - API Specification (`konnect_api_product_specification.kongair_flights_spec`)
   - API Documents (multiple)

4. **Portal Content**
   - Portal Appearance (`konnect_portal_appearance.kongair_portal_customization`)
   - Portal Pages (home, guides, etc.)
   - Portal Snippets (reusable content)

5. **Publications**
   - Portal Product Version (`konnect_portal_product_version.kongair_flights_publication`)

## Key Differences from kongctl

### Supported Features

- ✅ Portal configuration and basic customization
- ✅ API products with versions and specifications
- ✅ Portal pages with hierarchy
- ✅ Portal snippets
- ✅ Application auth strategies
- ✅ API product documentation
- ✅ Portal publications

### Limitations

- ⚠️ **Menu Configuration**: The kongctl configuration includes detailed menu structures (main menu, footer sections). The Terraform provider's `konnect_portal_appearance` resource does not support menu configuration. These may need to be configured via the Konnect UI or API directly.
- ⚠️ **Layout Settings**: The `layout: "topnav"` setting from kongctl is not directly mappable to Terraform.
- ⚠️ **Data Sources**: The configuration uses data sources to reference existing control planes and gateway services. You may need to replace these with actual resource definitions if managing those resources with Terraform.

### File References

The Terraform configuration uses `file()` functions to load content from the source kongctl directory:

```hcl
content = file("${path.module}/../cfg/portal/pages/home.md")
```

This keeps the content in sync with the original kongctl configuration.

## Commented Resources

The original kongctl configuration (`cfg/portal/apis.yaml`) includes commented-out API definitions for:
- Routes API
- Bookings API
- Customer Information API

These were intentionally excluded from the Terraform conversion. To add them:

1. Uncomment the relevant sections in `cfg/portal/apis.yaml`
2. Create corresponding Terraform resources following the pattern in `api_products.tf`
3. Add appropriate documentation and specification resources

## Maintenance

### Adding New API Products

1. Create the API product resource in `api_products.tf`
2. Create the API product version
3. Add the OpenAPI specification (base64 encoded)
4. Add any documentation resources
5. Create a publication in `portal_publications.tf`

### Adding New Portal Pages

Add resources to `portal_pages.tf` following the existing pattern. Use `parent_page_id` for hierarchical pages.

### Updating Content

Content is loaded from the `cfg/` directory. Update the source files and run `terraform apply` to sync changes.

## Terraform State

This configuration will create Terraform state files. For production use:

1. Configure remote state backend (S3, Terraform Cloud, etc.)
2. Enable state locking
3. Consider using workspaces for multiple environments

Example backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "kongair/portal/terraform.tfstate"
    region = "us-west-2"
  }
}
```

## Troubleshooting

### Data Source Not Found

If you see errors about control planes or gateway services not found:
- Verify the resources exist in your Konnect organization
- Check the names in `data_sources.tf` match exactly
- Ensure your access token has appropriate permissions

### Base64 Encoding Issues

The OpenAPI specification must be base64 encoded. If you need to re-encode:

```bash
base64 -i cfg/portal/apis/flights/openapi.yaml | tr -d '\n'
```

### File Path Issues

Ensure you're running Terraform from the `tf/` directory. The `file()` functions use relative paths from the module root.

## Additional Resources

- [Kong Konnect Terraform Provider Documentation](https://registry.terraform.io/providers/Kong/konnect/latest/docs)
- [Kong Konnect Documentation](https://docs.konghq.com/konnect/)
- [kongctl Documentation](https://github.com/Kong/kongctl)

## Support

For issues or questions:
- Kong Terraform Provider: https://github.com/Kong/terraform-provider-konnect
- Kong Konnect Support: https://support.konghq.com/
