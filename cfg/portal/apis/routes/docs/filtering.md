# Routes API: Filtering

The Routes API keeps filtering intentionally simple to support high-speed
lookups. This guide covers the supported query options and practical
implementation details.

## Filter by Origin

Pass multiple `origin` values to limit the response to specific departure
airports:

```bash
curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
     --get https://api.kong-air.com/routes \
     --data-urlencode "origin=LHR" \
     --data-urlencode "origin=LGW"
```

- Repeat the `origin` parameter to request several airports in one call.
- KongAir validates codes against the airline's operating certificate; invalid
  entries are ignored, and the response only contains the routes that exist.

## Enrich Route Metadata

The Routes API response pairs nicely with your own airport directory. Join on
`origin` and `destination` to display full airport names and timezone
information.

Example SQL join:

```sql
SELECT
  r.id,
  o.airport_name AS origin_name,
  d.airport_name AS destination_name,
  r.avg_duration
FROM kongair_routes r
JOIN airports o ON r.origin = o.iata_code
JOIN airports d ON r.destination = d.iata_code;
```

## Handling Missing Routes

If `GET /routes/{id}` returns `404`, ensure the requested city pair is part of
KongAir's network. Consider a graceful fallback in your UI (e.g., show nearby
airports) and log the incident for network planning discussions.

## Performance Guidance

- Each response is gzip-compressed. Enable compression in your HTTP client to
  reduce transfer size.
- Cache the full `/routes` list for 24 hours unless the `ETag` header changes.
- Expect new seasonal routes in March and October. Maintain automated tests that
  assert important routes remain available.
