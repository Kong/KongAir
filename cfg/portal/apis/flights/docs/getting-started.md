# Flights API: Getting Started

The Flights API exposes KongAir's published schedule and flight metadata. Use it
when you need to show upcoming departures, validate a booking, or enrich
operational dashboards with real-time availability.

## Base URL

All requests are served from the KongAir public API cluster:

```
https://api.kong-air.com
```

The service currently offers read-only endpoints. Common resources include:

- `GET /flights` — retrieve the flights scheduled for a given day
- `GET /flights/{flightNumber}` — look up a single flight by flight number
- `GET /flights/{flightNumber}/details` — fetch extended cabin and aircraft data

## Quick Start

1. **Obtain credentials** from the KongAir Partner team. Sandbox and production
   credentials work against the same hostname but map to different API keys.
2. **Call the health check** to confirm connectivity:
   ```bash
   curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
        https://api.kong-air.com/health
   ```
3. **Request the daily schedule** for London Heathrow departures:
   ```bash
   curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
        --get https://api.kong-air.com/flights \
        --data-urlencode "date=2024-04-04"
   ```
4. **Cache responses** for a few minutes. Flights change infrequently; staying
   within the published rate limits keeps response times predictable.

## Rate Limits

The default rate limit for the sandbox is **200 RPM** per integration. Production
allocations scale with contracted usage. Contact your KongAir partner manager if
you expect higher burst traffic (for example, during timetable releases).

## Next Steps

- Explore filtering techniques in the [Query Patterns](./flights-query-patterns)
  guide.
- Review the [Flights API data model](./flights-data-model) for field-level
  details and sample payloads.
- Pair the Flights API with the Routes API to enrich origin/destination
  information and average flight durations.
