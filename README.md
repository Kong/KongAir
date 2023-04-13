# KongAir

An example Kong application based on a fictitious airline, Kong Air.

This project will aim to provide working examples of various Kong, Inc. technolgies including [Kong Konnect](https://docs.konghq.com/konnect/) and [APIOps](https://github.com/Kong/go-apiops).

The repository is modeled as a shared monorepo with various teams having their code and configurations stored in folders at the top level.  For example, the fictitious "Flight Data" team stores their projects in the [flight-data](flight-data/) subfolder.

Also modeled here is a simulated central governance team, named [platform](platform/). This team mimics the typical responsibility of a central team that manages shared infastructure, like API Gateways.

Automated APIOps processes are exemplified in [GitHub Actions](.github/workflows) using the Kong APIOps capabilities.

Over time this repository will grow to include additional functionality, including real world deployments to Kong Konnect, usage of APIs and  the declarative management tool [deck](https://docs.konghq.com/deck/latest/).

## Examples

* The [OAS to Kong](https://github.com/Kong/KongAir/blob/main/.github/workflows/oas-to-kong.yaml) workflow converts multiple team's OpenAPI Specs to Kong declarative configurations, merges multiple files into a single configuration, and patches the resulting file with internal hostnames. 
