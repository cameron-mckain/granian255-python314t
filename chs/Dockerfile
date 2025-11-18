# CHS (COPE Health Scholars) Specialized Image
# Builds on top of granian-python314t base which includes:
#   Django 5.2.8, Granian 2.5.7, numpy, scipy, pandas, matplotlib,
#   psycopg, djangorestframework, django-filter, django-cors-headers,
#   django-extensions, django-picklefield, channels-redis, graphene-django,
#   awscli, boto3, lxml, requests, beautifulsoup4, Pillow, etc.

FROM containers.github.projectunity.io/mckain/granian-python314t:latest

# Install PostGIS/GeoDjango system dependencies (not in base image)
RUN yum install -y \
    gdal \
    gdal-devel \
    geos \
    geos-devel \
    proj \
    proj-devel \
    postgresql-devel \
    && yum clean all

# Copy pre-built grpcio wheel for Python 3.14t (saves ~10min compilation)
COPY wheels/chs/*.whl /tmp/chs-wheels/

# Install Celery and task queue packages (not in base image)
RUN python3.14t -m pip install \
    celery \
    redis \
    django-celery-beat \
    django-celery-results

# Install external service API clients (CHS-specific)
RUN python3.14t -m pip install \
    stripe \
    simple-salesforce \
    canvasapi \
    zeep

# Install additional Django packages (CHS-specific, not in base image)
RUN python3.14t -m pip install \
    django-nested-admin \
    django-better-admin-arrayfield \
    django-localflavor \
    django-phonenumber-field \
    django-environ \
    whitenoise

# Install Elasticsearch integration
RUN python3.14t -m pip install \
    django-elasticsearch-dsl \
    elasticsearch

# Install grpcio from pre-built wheel (dependency for opentelemetry)
RUN python3.14t -m pip install \
    /tmp/chs-wheels/grpcio-*.whl

# Install monitoring and observability packages
RUN python3.14t -m pip install \
    django-prometheus \
    python-json-logger \
    opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-instrumentation-django \
    opentelemetry-instrumentation-psycopg2 \
    opentelemetry-instrumentation-redis \
    opentelemetry-instrumentation-celery \
    opentelemetry-exporter-otlp

# Clean up wheels
RUN rm -rf /tmp/chs-wheels

# Expose port 8000
EXPOSE 8000

# Default command
CMD ["python3.14t", "--version"]
