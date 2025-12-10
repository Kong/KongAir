# Bookings API: Errors and Retries

Understanding common error codes helps you deliver a resilient booking
experience and minimize customer frustration.

## HTTP Status Codes

| Status | Meaning | Recommended Action |
| ------ | ------- | ------------------ |
| `400 Bad Request` | Payload failed validation. | Display validation messaging to the traveler. |
| `401 Unauthorized` | Token missing or expired. | Restart the OAuth flow and retry once. |
| `403 Forbidden` | Token lacks `bookings.write`. | Request the correct scope or alert support. |
| `404 Not Found` | Flight number invalid or seat unavailable. | Prompt the traveler to pick a different flight/seat. |
| `409 Conflict` | Concurrent booking detected. | Ask for confirmation before retrying with a new seat. |
| `500/502/503` | Platform issue. | Retry with exponential backoff; show a graceful error.

## Idempotency

The Bookings service is idempotent for booking creation. If you send the same
`flight_number` and `seat` combination within 5 minutes, the API returns the
same ticket number. Include an `Idempotency-Key` header for extra protection
when integrating across multiple services.

## Retry Strategy

- **Network/5xx errors**: retry up to 3 times with exponential backoff (e.g.
  1s, 4s, 9s) and full jitter.
- **409 Conflict**: prompt the traveler to select a different seat before
  retrying.
- **429 Too Many Requests**: respect the `Retry-After` header. KongAir enforces
  rate limits aggressively to protect booking inventory.

## Logging and Support

Log the following for every failed request:

- Timestamp and `x-request-id`
- Token subject (`sub` claim)
- Flight number and seat when available

Share this information with KongAir Support for faster troubleshooting.
