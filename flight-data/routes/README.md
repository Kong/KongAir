## Routes API

Provides the KongAir routing information including flight origin and destination codes.
The API also provdes average duration of flight time for each route.

### Specification

The API specification can be found in the [openapi.yaml](openapi.yaml) file.

### Usage

The repository provides a `Makefile` with common usage.

#### To run unit tests

```
make test
```

#### To build the server

```
make build
```

#### To run the server on the default port

```
make run
```

In the `Makefile`, the default port is read from the `KONG_AIR_ROUTES_PORT`
env var which is loaded via the parent [base.mk](../../base.mk) file.

Alternatively the desired port can be passed to the built server executable directly,
for example:

```sh
./routes <port>
```

### Example client requests

Get all routes:
```
curl -s localhost:8081/routes
```

Get route by route code
```
curl -s localhost:8081/routes/LHR-SIN
```

