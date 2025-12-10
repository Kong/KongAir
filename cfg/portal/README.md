# KongAir Developer Portal Configuration

This directory contains a declarative configuration for the KongAir API portfolio
using the `kongctl` CLI. It publishes four KongAir services (Flights, Routes,
Bookings, and Customer Information) to a single developer portal and bundles
their OpenAPI specifications, product documentation, and portal content.

## Structure

```
apis.yaml        # API catalogue and portal publications
portal.yaml      # Portal definition, navigation, and content tree
apis/            # Source OpenAPI specs and API-specific docs
pages/           # Portal pages rendered in the developer portal
snippets/        # Reusable content blocks referenced by pages
```

To apply the configuration:

```bash
kongctl sync -f cfg/portal/portal.yaml -f cfg/portal/apis.yaml
```

All referenced files live under `cfg/portal`, so the configuration can be copied
or versioned as a self-contained example.
