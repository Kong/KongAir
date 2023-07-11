## KongAir's experience API

A GraphQL API implemented in Apollo server,
designed to aggregate the KongAir REST APIs to help drive end user
applications.

## Requirements

* NodeJS (tested with version 17.9.1)
* npm (tested with version 8.11.0)
* Nodemon for dev servers (tested with version 2.0.22)

This GraphQL service depends on the following KongAir REST API services, as they
provide the upstream data source for the experience API. By default, the
`.env` file in this folder configures the upstream REST APIs to be serviced by
a hosted version of this application at `api.kong-air.com`.  If you would like to 
run a local version of these services, see the [run-all.sh](../run-all.sh) 
script in the parent directory. You'll also need to change the configured in the
[.env](.env) file to point to the localhost versions of the upstream services.

Each upstream REST API and the GraphQL server accept configurations
using `dotenv` (see the `.env` file in each repository).

See:
* [Routes](../flight-data/routes/README.md)
* [Flights](../flight-data/flights/README.md)
* [Customer](../sales/customer/README.md)
* [Bookings](../sales/bookings/README.md)

## Server Usage

To install dependencies:
```
npm install
```

For the default server:
```
npm start
```

For an auto-reloading dev server:
```
npm run dev
```


Once the server is running you can use the helper `query.sh` script, or you can
point a web browser at the Apollo Studio hosted on the server.

For the studio, point your web browser to:
http://localhost:4000

Customers within the requests are identified by a JWT bearer token. This server is coded
as an example only, and only accepts unsigned tokens. **For
production use cases, proper token signing should be utilized.**

The tokens are passed to the upstream REST APIs to identify the requesting customer.

Example tokens are provided in the [JWT.env](../../JWTs.env) file,
which can be sourced into your environment and then used for client
requests.

To run a query on the command line, you can run something like the following:

```sh
./query.sh $JDOE '{ "query": "{ me { name username bookings { seat flight { route_id route { origin destination avg_duration } } } } }" }'
```
