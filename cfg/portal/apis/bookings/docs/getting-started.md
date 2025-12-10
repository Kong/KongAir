# Bookings API: Getting Started

The Bookings API lets you create and retrieve KongAir reservations on behalf of
customers. Typical use cases include powering digital check-in, travel agency
portals, and self-service itinerary changes.

## Capabilities

- Retrieve current bookings for the authenticated customer with `GET /bookings`.
- Create new bookings with `POST /bookings`.
- Verify platform health using `GET /health` before presenting the booking flow.

## Authentication

The Bookings API requires customer-scoped OAuth 2.0 tokens. Applications obtain
an access token by exchanging an authorization code granted by the traveler.
Include the token in the `Authorization: Bearer` header for every request.

## Create a Booking

```bash
curl -X POST https://api.kong-air.com/bookings \
  -H "Authorization: Bearer $KONGAIR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
        "flight_number": "KA924",
        "seat": "32A"
      }'
```

A successful response returns:

```json
{
  "ticket_number": "CDF3412"
}
```

## Retrieve Bookings

```bash
curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
     https://api.kong-air.com/bookings
```

Store the `ticket_number` and seat allocation in your CRM so operations teams
can reference customer history quickly.

## Sandbox Strategy

- Sandbox flights use fictitious flight numbers in the `KA9xx` and `KA8xx`
  ranges. Production flight numbers mirror the live schedule.
- Booking creation is idempotent by `flight_number` + `seat`. Retries with the
  same payload return the first issued ticket number.
- Webhooks for booking events are optional but recommended for real-time
  notifications. See [Real-time Booking Updates](../../../pages/guides/manage-bookings/real-time-updates.md).
