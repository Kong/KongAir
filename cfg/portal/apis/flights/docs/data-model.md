# Flights API: Data Model

The Flights API returns JSON payloads describing scheduled flights along with
optional enrichment fields. Understanding the schema ensures the downstream data
model stays in sync.

## `Flight`

| Field | Type | Description |
| ----- | ---- | ----------- |
| `number` | string | KongAir flight number (e.g. `KA924`). |
| `route_id` | string | Identifier of the origin/destination pair (matches Routes API IDs). |
| `scheduled_departure` | string (date-time) | Planned departure timestamp in ISO-8601 UTC. |
| `scheduled_arrival` | string (date-time) | Planned arrival timestamp in ISO-8601 UTC. |

### Sample

```json
{
  "number": "KA924",
  "route_id": "LHR-SFO",
  "scheduled_departure": "2024-06-01T09:15:00Z",
  "scheduled_arrival": "2024-06-01T18:55:00Z"
}
```

## `FlightDetails`

| Field | Type | Description |
| ----- | ---- | ----------- |
| `flight_number` | string | Identifier for the flight the details belong to. |
| `in_flight_entertainment` | boolean | Indicates availability of KongAir Kino streaming. |
| `meal_options` | array(string) | Available meal selections. |
| `aircraft_type` | string | Aircraft operating the route (IATA equipment code). |

### Sample

```json
{
  "flight_number": "KA924",
  "in_flight_entertainment": true,
  "meal_options": ["standard", "vegetarian", "kids"],
  "aircraft_type": "A359"
}
```

## Versioning

The schema follows semantic versioning. Backwards-incompatible changes trigger a
major version increment in the OpenAPI file. Additive fields appear with minor
version bumps—poll the `/health` endpoint to discover new versions or subscribe
via the KongAir change log.
