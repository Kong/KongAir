# Flights API: Query Patterns

The `/flights` endpoint is intentionally simple and performs efficiently when you
shape requests carefully. This guide covers the supported patterns.

## Filter by Date

By default the API returns flights scheduled for the current UTC day.
Define the `date` query parameter to target a specific day:

```bash
curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
     --get https://api.kong-air.com/flights \
     --data-urlencode "date=2024-06-01"
```

- Use ISO-8601 calendar dates (YYYY-MM-DD).
- Historical lookup is supported for the last 30 days to aid post-event
  investigation.
- Future schedules are available up to 365 days out.

## Narrow Results After Retrieval

When you need to limit results by route or aircraft type, issue the request and
filter locally. Example in Python:

```python
import requests

resp = requests.get(
    "https://api.kong-air.com/flights",
    headers={"Authorization": f"Bearer {token}"},
    params={"date": "2024-06-01"},
)
resp.raise_for_status()

lhr_sfo = [flight for flight in resp.json() if flight["route_id"] == "LHR-SFO"]
```

## Fetch Details Lazily

Use the `GET /flights/{flightNumber}` and `GET /flights/{flightNumber}/details`
endpoints when you need to drill into a single flight:

1. Fetch the summary list via `/flights`.
2. Retrieve the specific flight record for the booking flow.
3. Fetch `/details` to render amenities or aircraft information on demand.

This lazy-loading pattern keeps your UI responsive and reduces the load on the
Flights API for casual browsing use cases.

## Pagination

The current version returns the full set of flights for the requested day.
Because schedules per day rarely exceed a few hundred entries, no explicit
pagination is required. Downstream consumers should still guard against large
payloads by enforcing timeouts and truncating to the segments required by the
user experience.

## Error Handling

- `401 Unauthorized` indicates the access token is missing or expired. Retry
  after obtaining a fresh token from your chosen OAuth flow.
- `429 Too Many Requests` signals a throttling event. Apply the `Retry-After`
  header value before retrying.
- `5xx` responses are rare and usually short-lived. Implement exponential backoff
  with jitter to keep traffic smooth during failover.
