# chs-granian-python314t

Specialized Docker image for the CHS (COPE Health Scholars) application with Python 3.14t (free-threaded), Django 5.2.8, Granian 2.5.7, GeoDjango/PostGIS support, and all required dependencies.

## Included Packages

### Core Framework
- Django 5.2.8
- Granian 2.5.7
- psycopg[binary] (PostgreSQL adapter)

### GeoDjango/GIS
- GDAL (system library)
- GEOS (system library)
- PROJ (system library)

### Task Queue & Background Processing
- celery
- redis
- django-celery-beat
- django-celery-results

### External Service Integrations
- stripe (payment processing)
- simple-salesforce (Salesforce CRM)
- canvasapi (Canvas LMS)
- zeep (SOAP client)
- boto3, awscli (AWS)

### Data Processing
- numpy
- scipy
- pandas
- matplotlib
- Pillow
- imagehash

### Django Extensions
- djangorestframework
- django-filter
- django-cors-headers
- django-extensions
- django-picklefield
- django-jsoneditor
- django-environ
- whitenoise
- nested-admin
- django-better-admin-arrayfield
- django-localflavor
- django-phonenumber-field
- django-postgres

### Search
- django-elasticsearch-dsl
- elasticsearch

### Monitoring & Observability
- django-prometheus
- python-json-logger
- opentelemetry-api
- opentelemetry-sdk
- opentelemetry-instrumentation-django
- opentelemetry-instrumentation-psycopg2
- opentelemetry-instrumentation-redis
- opentelemetry-instrumentation-celery
- opentelemetry-exporter-otlp

### Other
- lxml, beautifulsoup4, requests, requests-toolbelt
- pyyaml, python-magic, filetype
- channels-redis
- graphene-django, django-channels-graphql-ws

## Base Image

`quay.io/pypa/manylinux_2_28_x86_64:latest`

## Python Version

Python 3.14t (free-threaded experimental build)

Path: `/opt/python/cp314-cp314t/bin/python3.14t`

## Usage

### Pull from Container Registry

```bash
docker pull containers.github.projectunity.io/mckain/chs-granian-python314t:latest
```

### Local Build

```bash
cd chs
docker build -t chs-granian-python314t .
```

### Kubernetes Deployment

```yaml
spec:
  containers:
  - name: chs-web
    image: containers.github.projectunity.io/mckain/chs-granian-python314t:latest
    # ... rest of your config
```

## CI/CD

GitHub Actions automatically builds and pushes to GHES registry on every push to `main` that affects the `chs/` directory.

## Notable Exclusions

- **spacy** and spacy models (not needed for CHS application)
- **gunicorn** (using Granian instead)
- **opencv-python** (not compatible with Python 3.14t free-threading)

## Image Size

Approximately 1.5-2GB

## License

MIT
