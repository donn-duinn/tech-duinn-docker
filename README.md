# Tech Duinn Docker Stack

Docker Compose stack for the Tech Duinn infrastructure, running PostgreSQL, Redis, SearXNG, and Vaultwarden.

## Services

| Service       | Image                              | Port       | Description                        |
|---------------|------------------------------------|------------|------------------------------------|
| PostgreSQL    | `postgres:16-alpine`               | `5432`     | Primary database                   |
| Redis         | `redis:7-alpine`                   | `6379`     | Cache / message broker             |
| SearXNG       | `searxng/searxng:2026.5.31-…`      | `8080`     | Privacy-respecting meta search     |
| Vaultwarden   | `vaultwarden/server:latest`        | `8093`     | Lightweight Bitwarden-compatible pw manager |

All services sit on the `tech-duinn` bridge network and have health checks configured.

## Prerequisites

- Docker Engine 20.10+ and Docker Compose v2
- A `.env` file in the project root (see below)

## Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/donn-duinn/tech-duinn-docker.git
   cd tech-duinn-docker
   ```

2. **Create / edit the `.env` file:**
   ```bash
   cp .env.example .env   # if an example is provided
   ```
   Required variables:
   ```env
   POSTGRES_USER=<db-user>
   POSTGRES_PASSWORD=<db-password>
   SEARXNG_SECRET=<random-secret>
   VAULTWARDEN_ADMIN_TOKEN=<admin-token>
   ```

3. **Start the stack:**
   ```bash
   docker compose up -d
   ```

4. **Verify all services are healthy:**
   ```bash
   docker compose ps
   ```

## Usage

- **PostgreSQL:** Connect on `localhost:5432` with the user/password from `.env`.
- **Redis:** Connect on `localhost:6379`.
- **SearXNG:** Open `http://localhost:8080` in your browser.
- **Vaultwarden:** Open `http://localhost:8093` in your browser. Sign-ups are **disabled** by default; use the admin panel (`/admin`) with `VAULTWARDEN_ADMIN_TOKEN` to invite users.

## Stopping

```bash
docker compose down          # stop containers, keep data
docker compose down -v       # stop containers AND delete volumes (⚠ data loss)
```

## Volume Data

Persistent data is stored in named Docker volumes:

- `pg-data` — PostgreSQL data
- `redis-data` — Redis append-only file
- `searxng-data` — SearXNG config
- `vaultwarden-data` — Vaultwarden data

## License

Private / internal use — see repository settings.
