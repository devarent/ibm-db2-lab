<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# IBM Db2 Lab

<sub>Start IBM Db2 Community Edition in Docker, create a schema, and practice Db2 SQL and the command line processor.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-IBM%20Db2-054ADA?style=flat-square" alt="Database: IBM Db2" />
  <img src="https://img.shields.io/badge/Category-Relational%20%28SQL%29-6366F1?style=flat-square" alt="Category: Relational (SQL)" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/ibm-db2-lab/actions/workflows/compose-check.yml"><img src="https://github.com/devarent/ibm-db2-lab/actions/workflows/compose-check.yml/badge.svg" alt="compose-check" /></a>
</p>

## What this lab is

Db2 is a long-running enterprise relational database with strong SQL standards coverage. This lab runs Db2 Community Edition locally, shows the command line processor workflow, and gives you a schema plus queries that exercise identity columns, CTEs, and Db2-specific syntax.

## Quickstart

```bash
docker compose up -d
docker compose logs -f db2   # wait for: Setup has completed
docker compose cp examples/01_schema.sql db2:/tmp/01_schema.sql
docker compose exec db2 su - db2inst1 -c 'db2 -tvf /tmp/01_schema.sql'
docker compose exec db2 su - db2inst1 -c 'db2 connect to LAB && db2 "SELECT current_server, current_time FROM sysibm.sysdummy1"'
```

## Connection details

| Field | Value |
| --- | --- |
| Host | `localhost` |
| Port | `50000` |
| Database | `LAB` |
| User | `db2inst1` |
| Password | `db2inst1` |
| JDBC URL | `jdbc:db2://localhost:50000/LAB` |
| CLP | `db2 connect to LAB` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/compose-check.yml`](.github/workflows/compose-check.yml) | Validates the Compose file on every push. |
| [`examples/01_schema.sql`](examples/01_schema.sql) | Db2 schema with identity columns, constraints, and a summary view. |
| [`examples/02_queries.sql`](examples/02_queries.sql) | Seed data, a CTE, `FETCH FIRST`, and a window function. |

## Exercises

1. Run `db2 -tvf examples/02_queries.sql` and inspect the output of `order_summary`.
2. Add a `products` table and a `MERGE` statement that upserts prices.
3. Use `db2expln` or `EXPLAIN PLAN FOR` to inspect the access plan for the revenue query.
4. Create a tablespace and move an index into it (requires more Db2 administration than the default lab setup).

## Notes and limits

- The image is large (several GB) and needs roughly 4 GB of RAM. First start can take 5-10 minutes.
- Db2 Community Edition is free for development, but review IBM's license terms before production use.
- The container runs as privileged because Db2 needs kernel settings that the image manages itself.
- This image is published for linux/amd64. Apple Silicon users need emulation.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [Db2 documentation](https://www.ibm.com/docs/en/db2)
- [Db2 Community Edition image](https://containerization.ibm.com/)
- [Db2 JDBC driver](https://www.ibm.com/docs/en/db2/11.5?topic=driver-jdbc)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
