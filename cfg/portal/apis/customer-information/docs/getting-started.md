# Customer Information API: Getting Started

The Customer Information API centralizes traveler profiles, payment methods, and
loyalty data. It is designed for trusted partners that need to synchronize
customer records across digital channels.

## Available Endpoints

- `GET /customer` — fetch the profile for the authenticated customer.
- `GET /health` — verify service availability.

Each response returns a `Customer` document that bundles top-level identity
attributes with the nested `information` object containing contact details and
payment methods.

## Authentication

The API requires OAuth 2.0 tokens with the `customer.read` scope. Tokens can be
issued for customers (preferred) or service accounts (for administrative
backfills). Include the token in the `Authorization` header.

## Sample Response

```json
{
  "id": "55e4f53b-952c-4a35-bd27-7cdc32db4fd7",
  "username": "travelnerd42",
  "name": "Mina Flores",
  "information": {
    "address": "742 Evergreen Terrace, Springfield",
    "phone_number": "+14155551212",
    "email": "mina.flores@example.com",
    "frequent_flier_number": "KA9022331",
    "payment_methods": [
      {
        "id": "pm_10892",
        "redacted_card_number": "•••• 4242",
        "card_holder_name": "Mina Flores",
        "expiration-date": "2026-04"
      }
    ]
  }
}
```

## Data Protection

- Personally identifiable data is encrypted at rest. KongAir guarantees GDPR and
  CCPA compliance for hosted information.
- Payment method tokens are redacted; your systems should only store the `id`
  and the masked card metadata shown above.
- Always request customer consent before persisting profile data outside of
  KongAir systems.
