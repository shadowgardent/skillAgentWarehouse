---
name: database-performance-and-caching
description: Advanced database performance tuning, PostgreSQL indexing and EXPLAIN query optimization, Redis multi-tier caching patterns, connection pooling, and asynchronous messaging queues.
---

# Database Performance Tuning & Caching Architecture

## 1. Indexing Strategies & Query Optimization
- **Index Architecture**:
  - **B-Tree Indexes**: Standard for equality (`=`) and range queries (`<`, `<=`, `>`, `>=`, `BETWEEN`).
  - **Composite Indexes**: Follow the Leftmost Prefix Rule (`INDEX(tenant_id, status, created_at)`).
  - **Partial Indexes**: Index only active/frequent subsets (e.g., `WHERE status = 'ACTIVE'`) to keep index sizes small and cache-friendly.
  - **GIN / Full-Text Indexes**: For JSONB structures (`jsonb_path_ops`) and search queries.
- **Query Analysis**:
  - Run `EXPLAIN (ANALYZE, BUFFERS)` to diagnose Seq Scans, temporary disk writes, and high buffer reads.
  - Eliminate N+1 query patterns: use eager loading, explicit joins, batch fetching, or DataLoader.
  - Avoid `SELECT *`: fetch only explicitly required columns to minimize serialization overhead and memory consumption.

## 2. Redis Caching Patterns & Strategy
- **Standard Cache Architectures**:
  - **Cache-Aside (Lazy Loading)**: Read from cache; on miss, query database, populate cache with TTL, and return.
  - **Write-Through / Cache Invalidation**: Invalidate or update cached keys immediately upon database mutations (`DEL user:123:profile`).
  - **Key Naming Convention**: Use hierarchical colon-separated namespaces (`<domain>:<entity_id>:<subfield>`, e.g., `app:user:8912:auth`).
- **Resilience & Cache Stampede Prevention**:
  - Set explicit TTL on all cache keys to prevent memory leaks.
  - Add random jitter to TTL (`TTL = base + rand(30, 90)`) to avoid synchronized mass expirations.
  - Protect high-traffic cache misses with distributed locks or probabilistic early recomputation (XFetch / singleflight).

## 3. Database Connection Pooling
- **Connection Management**:
  - Use external connection pooling (e.g., PgBouncer) or internal driver pools (Prisma `connection_limit`, HikariCP) in serverless / containerized setups.
  - Size pool according to database CPU core counts (`connections = (core_count * 2) + effective_spindle_count`).
  - Configure pool idle timeouts, connection timeouts, and keepalive intervals to prevent zombie connection leaks.

## 4. Asynchronous Task Queues & Offloading
- Offload non-critical, slow, or third-party operations out of the request-response cycle using queues (BullMQ with Redis, RabbitMQ, or Kafka).
- Implement idempotent job handlers with retry backoff (exponential backoff with jitter) and Dead Letter Queues (DLQ) for failed jobs.
