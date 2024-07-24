# KongAir

This repository implements an example [APIOps](https://github.com/Kong/go-apiops) pipeline for the Kong Gateway.

The repository is based on the fictitious airline KongAir, and is modeled as a shared monorepo in which 5 teams have their code and configurations stored in folders at the top level:

* The [flight-data](flight-data/) team owns two public facing APIs that serve KongAir's flight data information services
including the [routes](flight-data/routes/) and [flights](flight-data/flights/) services.
* The [sales](sales/) engineering team owns two services that service customer needs. The [customer](/sales/customer/)
service hosts customer information including payment methods, frequent flyer information, etc...
The [bookings](/sales/bookings/) service manages customer flight bookings and depends on the public flight-data team
services.
* The [experience](experience/) team owns one service. This team uses GraphQL and builds "experience" APIs to drive applications. The experience APIs aggregate the other KongAir REST APIs to make a dynamic unified API for applications.
* The [platform](platform/) team is responsible for populating certain kong entities and apply governance
rules, but doesn't own any service. It mimics the typical responsibility of a central team that manages shared infastructure, like API Gateways.


## Workflows

Automated APIOps processes are exemplified in [GitHub Actions](.github/workflows) using the Kong APIOps capabilities.

### Stage changes for Kong
[This workflow](.github/workflows/stage-changes-for-kong.yaml) stages changes for the Kong Gateway configuration.

#### Jobs Overview

1. **Job: `has-changes`**
   - Checks if there are any changes in relevant files like specifications, configurations, or pipeline files.

2. **Job: `oas-break`**
   - Checks for breaking changes in the OpenAPI Specifications (OAS) and creates an issue if any are found.

3. **Job: `contract-test`**
   - Runs contract testing using SchemaThesis based on the OpenAPI specifications of the services.

4. **Job: `security-test`**
   - Runs security testing using OWASP ZAP Scan on the services' OpenAPI specifications.

5. **Job: `load-test`**
   - Executes load testing using K6, generating scripts from the OpenAPI specifications.

6. **Job: `oas-to-kong`**
   - Converts OpenAPI Specifications to Kong configurations, combines them, and creates a pull request for the changes.

7. **Job: `oas-changelog`**
   - Generates and posts a changelog of differences between the previous and current OAS for all services as a PR comment.

```mermaid
graph TD;
  A[has-changes] -->|changes detected| B[oas-break];
  A -->|changes detected| C[contract-test];
  A -->|changes detected| D[security-test];
  A -->|changes detected| E[load-test];
  B --> F[oas-to-kong];
  C --> F;
  D --> F;
  F --> G[oas-changelog];
```

### Stage Kong configuration for production
[This workflow](.github/workflows/stage-kong-for-PRD.yaml) stages changes for the Kong Gateway production configuration.

#### Jobs Overview

1. **Job: `stage-kong-for-prd`**
   - Stages the updated Kong configuration for production by copying the generated file, calculates configuration differences, and creates a pull request to deploy the changes to production.

### Deploy Kong to production

[This workflow](.github/workflows/deploy-kong-PRD.yaml) deploys changes to the Kong Gateway.

#### Jobs Overview

1. **Job: `deploy-kong`**
   - Checks out the repository, sets up the Deck tool, and synchronizes the Kong configuration with the appropriate deployment target (Konnect, Kong EE, or Kong Ingress Controller).

### Generate docker images

[This workflow](.github/workflows/docker.yaml) builds and pushes Docker images for each one of the KongAir services.
#### Jobs Overview

1. **Job: `docker`**
   - Checks out the repository, sets up QEMU and Docker Buildx, logs into Docker Hub, and builds and pushes Docker images for each specified service using a matrix strategy.

## How to use this repository

### clone
### enable issues
### change repository name in docker.yaml
### schemathessi account