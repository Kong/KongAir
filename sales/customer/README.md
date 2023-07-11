## Customer Information API

Provides the KongAir customer information service including
payment methods, contact info, frequent flyer, etc...

The API specification can be found in the [openapi.yaml](openapi.yaml) file.

Customers are identified by a JWT bearer token. This server is coded
as an example only, and only accepts unsigned tokens. **For
production use cases, proper token signing should be utilized.**

The token payload should contain a `username` field as follows:
```
{
  "username": "dfreese"
}
```

This username is how the service segments customer information.

Example tokens are provided in the [JWT.env](../../JWTs.env) file,
which can be sourced into your environment and then used for client
requests. Examples are provided below.

As of now, this example server does not provide a way to update customer
information, only to retrieve it with a `GET` request. The server loads
example customer information from the [customer.json](customer.json) file.

### Prerequisites

* `node` : tested with `v17.9.1`
* `npm`  : tested with `8.11.0`

### Server usage

To install dependencies:
```
npm install
```

The repository provides a `Makefile` with common usage.

#### To run unit tests

```
make test
```

#### To run the server on the default port

```
make run
```

For the run command, the default port is read from the `KONG_AIR_CUSTOMER_PORT`
env var which is loaded via the parent [base.mk](../../base.mk) file.

#### To run a development server

A development server will detect and autoloads code changes.

```
npm run dev
```

### Example client requests

The following examples assume you have environment variables set with
valid unsigned bearer tokens that contain a `username` field. An environment
file, [JWT.env](../../JWTs.env), is provided that contains example tokens.

Source the example tokens into your environment:
```
source ../../JWTs.env
```

Read all customer information for the user `dfreese`:
```
curl -s -H "Authorization: Bearer ${DFREESE}" localhost:8083/customer
```

