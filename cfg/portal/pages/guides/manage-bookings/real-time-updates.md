# Real-time Booking Updates

Receive booking events moments after they happen so downstream systems remain in
sync.

::snippet
---
name: "kongair-page-toc"
---
::

## Subscribe to Webhooks

1. Request access to the `bookings.created`, `bookings.updated`, and
   `bookings.canceled` topics from your KongAir account team.
2. Deploy an HTTPS endpoint that validates KongAir signatures using the shared
   secret provided during onboarding.
3. Respond with `2xx` within 5 seconds. KongAir retries failed deliveries with
   exponential backoff for up to 24 hours.

## Event Payload

```json
{
  "type": "bookings.created",
  "version": "1.0",
  "data": {
    "ticket_number": "CDF3412",
    "flight_number": "KA924",
    "seat": "32A",
    "customer_id": "55e4f53b-952c-4a35-bd27-7cdc32db4fd7"
  }
}
```

## Reconciliation

- After processing an event, call `GET /bookings` with the customer's token to
  confirm the latest state.
- Store the event payload alongside the API response to simplify back-office
  auditing.
- Detect stale events by inspecting the `version` field—future schema versions
  will publish a new number.

## Security Checklist

- Enforce TLS 1.2 or higher.
- Rotate webhook secrets every 90 days.
- Reject requests without a valid `x-kongair-signature` header.
