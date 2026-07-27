# KongAir Repository Overview

KongAir is a **demo monorepo** for a fictional airline. It shows how multiple engineering teams can share one repository while using **Kong Konnect**, **APIOps** (deck), and a **Developer Portal**.

It is primarily a reference/learning project: run APIs locally for development, and use Konnect for the gateway and portal. It is not a prescribed “deploy to a cloud VM” application.

---

## High-level layout

```text
Business APIs              Kong Gateway                    Developer Portal
─────────────────          ─────────────────               ─────────────────
flight-data/               platform/kong/                  cfg/portal/  (kongctl)
sales/                     + team */kong/ patches     →    tf/          (Terraform)
experience/                → PRD/kong/kong.yaml
                           (deck → Konnect PRD)
```

Top-level folders map to fictitious teams, not a single flat app.

---

## Teams and services

### `flight-data/`

Owns public flight-data APIs:

| Service | Stack | Role |
|---------|--------|------|
| `flights/` | Go | Flight numbers and details |
| `routes/` | Go | Origins, destinations, average durations |

Each service includes OpenAPI (`openapi.yaml`), a `kong/` folder with gateway patches, and a Dockerfile.

### `sales/`

Owns customer-facing APIs:

| Service | Stack | Role |
|---------|--------|------|
| `customer/` | Node.js | Customer profile, payment methods, frequent flyer |
| `bookings/` | Node.js | Flight bookings (depends on flight-data) |

Customers are identified with JWT bearer tokens (demo tokens in `JWTs.env`; unsigned tokens for example use only).

### `experience/`

GraphQL “experience” API (Apollo Server) that aggregates the REST APIs for client apps. By default, `.env` points upstreams at the hosted demo (`https://api.kong-air.com/`). Comment in the localhost URLs to use local services.

### `platform/`

Simulated central platform / governance team. Manages shared Kong Gateway concerns (consumers, groups, ACME, vaults, base config) under `platform/kong/`. Not a business API.

---

## Kong Gateway configuration

### Team `kong/` folders

Each API team keeps gateway snippets and patches (e.g. service host, plugins) next to their service. Platform owns shared pieces.

### `PRD/kong/`

**PRD = production**, not a product-requirements document.

`PRD/kong/kong.yaml` is the combined, promoted **deck** config synced to the Konnect runtime group `KongAir-PRD`. GitHub Actions stage and deploy this file (see `.github/workflows/`).

### Gateway vs local APIs

Running APIs with `./run-all.sh` does **not** put Kong in front of them. Local traffic hits `localhost` ports directly.

The showcase gateway path is:

```text
Client → Kong Gateway (Konnect) → hosted upstreams (e.g. api.kong-air.com)
```

An optional **routes** team path (`flight-data/routes/dev/`) can expose a local process via **cloudflared** and sync config to a Konnect control plane—still a cloud gateway, not a local Kong container.

There is no root `docker-compose` for a local Kong Gateway.

---

## Developer Portal

### `cfg/portal/`

Declarative **kongctl** config for the KongAir Developer Portal:

- Portal definition, navigation, pages, snippets
- API catalogue and OpenAPI specs (Flights, Routes, Bookings, Customer)

Apply with:

```bash
kongctl sync -f cfg/portal/portal.yaml -f cfg/portal/apis.yaml
```

### `tf/`

Terraform equivalent of the same portal, using the **Kong Konnect** provider. Converted from `cfg/portal` and still loads markdown/OpenAPI content from `cfg/portal` via `file()`.

Requires `KONNECT_TOKEN` and an existing Konnect org (e.g. control plane named `kongair`).

`cfg/portal` and `tf/` are **related** (same portal, two tools). They are not 1:1—some kongctl features (detailed menus, certain layout settings) are limited or missing in Terraform, and some APIs in `apis.yaml` may be commented out and omitted from Terraform.

### Gateway vs Portal

| | Kong Gateway | Developer Portal |
|---|---|---|
| Job | Proxy and protect APIs at runtime | Document and productize APIs for developers |
| Config here | `platform/kong`, team `kong/`, `PRD/kong` | `cfg/portal`, `tf/` |
| Deploy | deck → Konnect runtime | kongctl or Terraform → Konnect portal |

---

## Automation and packaging

### `.github/workflows/`

APIOps examples:

- Build and push Docker images to `ghcr.io/kong/kongair-*`
- Assemble / stage Kong config toward `PRD/kong`
- Deploy Kong changes to Konnect PRD with deck

### Dockerfiles

Each service has a Dockerfile. Images support containerized hosting; this repo does not define full VM/Kubernetes app infrastructure.

---

## Running locally (APIs only)

### Prerequisites

- Go ≥ 1.20 (flight-data services)
- Node.js and npm (sales + experience; tested around Node 17.9 / npm 8.11)
- `make`

### Ports (`PORTS.env`)

| Port | Service |
|------|---------|
| 8080 | flights |
| 8081 | routes |
| 8082 | bookings |
| 8083 | customer |
| 8084 | experience |

### Steps

1. `npm install` in `sales/customer`, `sales/bookings`, and `experience` (or use `make build`)
2. From repo root: `./run-all.sh`
3. Optional: `source JWTs.env` for sample customer JWTs
4. Optional: point `experience/.env` at localhost upstreams

No Kong Gateway, Terraform, or Konnect token is required for this path.

---

## Mental model

| Goal | Where to look / what to do |
|------|----------------------------|
| Try the microservices | Local `./run-all.sh` |
| Shared gateway policy | `platform/kong/` |
| Per-API gateway patches | Each service’s `kong/` folder |
| Production gateway state | `PRD/kong/kong.yaml` → Konnect |
| Portal content (kongctl) | `cfg/portal/` |
| Portal as Terraform | `tf/` |
| CI / APIOps | `.github/workflows/` |

For more detail, see the READMEs in each team and service folder, and `tf/README.md` / `cfg/portal/README.md` for portal setup.
