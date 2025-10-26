# Custom Apache Superset Image

This custom Docker image is based on the official Apache Superset image with pre-installed database drivers for PostgreSQL and ClickHouse.

## Pre-installed Drivers

- **PostgreSQL**: `psycopg2-binary==2.9.9` - For connecting to PostgreSQL databases
- **SQLAlchemy Utils**: `sqlalchemy-utils==0.41.1` - Additional SQLAlchemy utilities
- **ClickHouse**: `clickhouse-driver==0.2.6` and `clickhouse-sqlalchemy==0.2.4` - For connecting to ClickHouse databases (including SigNoz)

## Building the Image

### Locally
```bash
docker build -t superset-custom:latest ./superset-custom
```

### Via GitHub Actions
Push changes to the `superset-custom/` directory and GitHub Actions will automatically build and push to `ghcr.io/cameron-mckain/superset-custom:latest`.

## Using the Image

### With Helm
Update your `values.yaml`:
```yaml
image:
  repository: ghcr.io/cameron-mckain/superset-custom
  tag: latest
  pullPolicy: Always
```

### Direct Docker Run
```bash
docker run -d -p 8088:8088 \
  -e "SUPERSET_SECRET_KEY=your-secret-key" \
  -e "SQLALCHEMY_DATABASE_URI=postgresql://user:pass@host:5432/superset" \
  ghcr.io/cameron-mckain/superset-custom:latest
```

## Supported Database Connections

This image supports connecting to:
- PostgreSQL databases (including CloudNativePG clusters)
- ClickHouse databases (including SigNoz)
- MySQL databases (driver available but not pre-installed)

## Version Information

- Base Image: `apache/superset:latest`
- Python: 3.10
- Superset: Latest stable version from upstream

## Maintenance

To update the base image or drivers:
1. Edit `Dockerfile` with new versions
2. Commit and push changes
3. GitHub Actions will automatically build and push the new image
