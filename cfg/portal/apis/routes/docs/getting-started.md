# Routes API: Getting Started

Use the Routes API to understand KongAir's airport network. It pairs IATA origin
and destination codes with average flight durations so you can validate routing
options during trip planning.

## Core Endpoints

- `GET /routes` — list all KongAir routes. Supports optional filtering by origin.
- `GET /routes/{id}` — retrieve a single route such as `LHR-SFO`.
- `GET /health` — confirm platform availability.

## Sample Call

```bash
curl -H "Authorization: Bearer $KONGAIR_TOKEN" \
     https://api.kong-air.com/routes/LHR-SFO
```

Response:

```json
{
  "id": "LHR-SFO",
  "origin": "LHR",
  "destination": "SFO",
  "avg_duration": 660
}
```

## Usage Tips

- Keep a local cache and refresh daily—routes do not change often.
- Use the route `id` to correlate schedules from the Flights API.
- Display average duration during booking to set traveler expectations.

## Next Steps

- Review [filtering strategies](./routes-filtering).
- Combine routes with [Flights API](../flights/docs/getting-started) data to
  build up a schedule explorer.
