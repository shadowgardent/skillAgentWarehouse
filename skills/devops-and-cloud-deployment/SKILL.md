---
name: devops-and-cloud-deployment
description: Production-grade DevOps engineering, multi-stage Docker containerization, Docker Compose orchestration, CI/CD automated pipelines, Nginx reverse proxy, and zero-downtime cloud deployment.
---

# Enterprise DevOps & Cloud Deployment Architecture

## 1. Multi-Stage Docker Containerization
- **Layer Optimization & Security**:
  - Always use minimal base images (`node:alpine`, `golang:alpine`, `python:slim`, `distroless`).
  - Separate `build` stage from `production` runtime stage to prevent dev dependencies and compilers from leaking into production images.
  - Run containers as non-root users (`USER node` or custom UID/GID).
  - Leverage BuildKit cache mounting (`RUN --mount=type=cache,target=...`) for fast deterministic builds.
  - Write strict `.dockerignore` files to exclude `.git`, `node_modules`, `.env`, and local build artifacts.

## 2. Container Orchestration with Docker Compose
- **Standardized Service Composition**:
  - Configure isolated bridge networks for internal services (e.g., `frontend-net`, `backend-net`, `db-net`).
  - Declare explicit `healthcheck` configurations with `interval`, `timeout`, and `retries` for database and API containers.
  - Enforce `depends_on` conditions (`service_healthy`) before booting dependent application services.
  - Manage persistent storage with named volumes for databases and shared assets.
  - Keep configuration declarative with environment interpolation via `.env`.

## 3. Web Server & Reverse Proxy (Nginx)
- **High-Performance Routing & Hardening**:
  - SSL/TLS termination with modern ciphers (TLSv1.2, TLSv1.3) and HTTP Strict Transport Security (HSTS).
  - Proxy header forwarding: `X-Real-IP`, `X-Forwarded-For`, `X-Forwarded-Proto`, and WebSocket upgrade directives (`Upgrade`, `Connection "upgrade"`).
  - Static asset caching (`Cache-Control: public, max-age=31536000, immutable`) and Brotli/Gzip compression.
  - Client request body limits, custom error pages, and upstream keepalive connections.

## 4. CI/CD Automated Pipelines (GitHub Actions)
- **Quality Gates & Continuous Delivery**:
  - **Stage 1 (Lint & Test)**: Run linters, type checks, and automated unit/integration tests with PR triggers.
  - **Stage 2 (Artifact Build)**: Build Docker images, scan for vulnerabilities (`Trivy` / `Snyk`), and push to container registry with git commit SHA tags.
  - **Stage 3 (Deploy)**: Automated or manual approval release to staging/production environments with secret masking.

## 5. Cloud Deployment & Operational Resilience
- **Twelve-Factor App Principles**:
  - Strict separation of config from code via environment variables.
  - Health endpoint implementation: `/healthz` (liveness) and `/ready` (readiness) for container orchestrators.
  - Graceful shutdown handling (`SIGTERM`/`SIGINT`) to drain active connections before container termination.
  - Zero-downtime deployment strategies (Rolling updates, Blue-Green, or Canary releases).
