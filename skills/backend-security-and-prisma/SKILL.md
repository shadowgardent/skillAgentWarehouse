---
name: backend-security-and-prisma
description: High-performance backend engineering, RESTful API design, PostgreSQL data modeling with Prisma, JWT rotation, and OWASP Top 10 security hardening.
---

# Enterprise Backend Architecture & Security Standard

## 1. Clean Architecture & Service-Repository Pattern
- **Controller/Router**: Input parsing, validation schema gating (Zod/Valibot), and HTTP status code mappings.
- **Service Layer**: Pure business logic, transaction boundaries, domain models.
- **Repository / ORM Layer**: Database queries, indexing strategies, optimized data access.

## 2. Database Modeling (Prisma & PostgreSQL)
- **Schema Optimization**:
  - Add explicit indexes `@@index([userId, createdAt])` for frequent filters and orderings.
  - Foreign key relations with explicit cascading delete or set null policies.
  - Decimal precision for currency/monetary fields (never use floating point).
- **Transactions & Concurrency**:
  - Wrap multi-table operations in `$transaction` to ensure ACID atomicity.
  - Mitigate race conditions (e.g., inventory deduction) using optimistic concurrency tokens or database row-level locking.

## 3. Defense-in-Depth Security (OWASP Top 10)
- **Input Validation & Sanitization**: Strict Zod schemas on all `body`, `query`, and `params`.
- **Authentication**:
  - Short-lived Access Tokens (e.g. 15 minutes) + Stored, rotatable Refresh Tokens.
  - Password hashing with `bcrypt` (work factor 12) or `argon2id`.
- **Rate Limiting & Abuse Prevention**:
  - Redis sliding window rate limiter on auth and resource-heavy endpoints.
- **Security Headers & CORS**:
  - Secure Helmet headers (HSTS, X-Content-Type-Options: nosniff, frameguard).
  - Explicit CORS origin allowlist (never wildcard `*` with credentials).
