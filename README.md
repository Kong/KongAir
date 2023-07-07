# KongAir

An example Kong application based on a fictitious airline, KongAir.

This project will aim to provide working examples of various Kong, Inc.
technolgies including [Kong Konnect](https://docs.konghq.com/konnect/)
and [APIOps](https://github.com/Kong/go-apiops).

The repository is modeled as a shared monorepo with various teams having
their code and configurations stored in folders at the top level.
For example, the fictitious "Flight Data" team stores their projects in the [flight-data](flight-data/) subfolder.

Also modeled here is a simulated central governance team, named [platform](platform/).
This team mimics the typical responsibility of a central team that manages shared infastructure, like API Gateways.

Automated APIOps processes are exemplified in [GitHub Actions](.github/workflows) using the Kong APIOps capabilities.

## Teams

* The [flight-data](flight-data/) team owns public facing APIs that serve KongAir's flight data information services
including the [routes](flight-data/routes/) and [flights](flight-data/flights/) services.
* The [sales](sales/) engineering team owns services that service customer needs. The [customer](/sales/customer/)
service hosts customer information including payment methods, frequent flyer information, etc...
The [bookings](/sales/bookings/) service manages customer flight bookings and depends on the public flight-data team
services.
* The [experience](experience/) team uses GraphQL and builds "experience" APIs to drive applications. The experience
APIs aggregate the other KongAir REST APIs to make a dynamic unified API for applications.
