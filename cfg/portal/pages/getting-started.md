# Getting Started with KongAir APIs

Follow these steps to provision access, test the services, and prepare for
production deployment.

## 1. Request Access

1. Complete the partner intake form shared by your KongAir representative.
2. Receive sandbox credentials (client id/secret) and the KongAir API Terms of
   Use.
3. Add your callback URLs to the KongAir identity platform allow list.

## 2. Install Tooling

- `kongctl` for declarative configuration workflows.
- Your preferred HTTP client (`curl`, Postman) or SDK generated from the
  OpenAPI files in this repository.
- Optional: `jq` for formatting JSON responses during debugging.

## 3. Validate Connectivity

```bash
curl -H "Authorization: Bearer $SANDBOX_TOKEN" \
     https://api.kong-air.com/health
```

A `200` response confirms network access from your environment.

## 4. Explore the APIs

- Call the [Flights API](../apis/flights/openapi.yaml) to list schedules.
- Use the [Routes API](../apis/routes/openapi.yaml) to enrich airport metadata.
- Generate bookings with the [Bookings API](../apis/bookings/openapi.yaml) to
  test downstream notifications.
- Retrieve loyalty data with the [Customer Information API](../apis/customer-information/openapi.yaml).

## 5. Move to Production

1. Submit your security checklist and penetration test results to KongAir.
2. Request production credentials and configure them in your secrets manager.
3. Flip traffic to production endpoints. Sandbox tokens remain valid for testing
   new features.

## Need Assistance?

- Email: `platform@kong-air.com`
- Office hours: Tuesdays and Thursdays, 08:00–10:00 PT
- Status page: `status.kong-air.com`
