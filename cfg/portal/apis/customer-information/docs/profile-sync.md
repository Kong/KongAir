# Customer Information API: Profile Sync

Synchronizing traveler profiles across channels ensures a consistent experience.
This guide outlines approaches for keeping your systems aligned with KongAir's
source-of-truth data.

## Polling Strategy

For lightweight integrations, poll `GET /customer` when the traveler signs in
and cache the profile for the duration of the session.

1. Retrieve the customer profile when the user authenticates.
2. Store the `id` and `frequent_flier_number` as stable identifiers.
3. Refresh the cache when the traveler changes profile fields inside your
   application.

## Event-driven Sync

Enterprise partners can subscribe to the KongAir Customer Events stream to react
to updates in near real time.

- Request access to the `customer.profile.updated` webhook.
- Host an HTTPS endpoint that validates KongAir signatures.
- When an event arrives, call `GET /customer` with the provided `customer_id`
  using your service account credentials and update downstream systems.

## Field Mapping Tips

| KongAir Field | Notes |
| ------------- | ----- |
| `username` | Unique handle within KongAir. Use as secondary identifier only. |
| `frequent_flier_number` | Primary loyalty identifier shared across channels. |
| `information.payment_methods[*].id` | Stable token. Never display raw card numbers. |
| `information.email` | Always treat as sensitive data; confirm ownership before sending transactional emails. |

## Error Handling

- `404` indicates the customer revoked data sharing. Remove cached data and
  prompt the traveler to reconnect.
- `401` means the token expired. Refresh credentials and retry once.
- Log all access for auditability, including the `x-request-id` header provided
  by KongAir.
