# CHS (COPE Health Scholars) Specialized Image
# Based on Python 3.14t (free-threaded) with Django, Granian, GeoDjango, and CHS-specific packages

FROM quay.io/pypa/manylinux_2_28_x86_64:latest

ARG PYTHON_VERSION=3.14t
ARG PYTHON_PATH=cp314-cp314t

# Install system development packages and PostGIS client libraries
RUN yum install -y \
    python3-devel \
    libxml2-devel \
    libxslt-devel \
    postgresql-devel \
    file-devel \
    mesa-libGL \
    # PostGIS/GeoDjango dependencies
    gdal \
    gdal-devel \
    geos \
    geos-devel \
    proj \
    proj-devel \
    && yum clean all

# Upgrade pip
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install --upgrade pip

# Install Django 5.2.8
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install django==5.2.8

# Install Granian 2.5.7
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install granian==2.5.7

# Install core Python packages (from base granian-python)
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    lxml \
    requests \
    requests-toolbelt \
    beautifulsoup4 \
    numpy \
    scipy \
    pandas \
    matplotlib \
    Pillow \
    imagehash \
    psycopg[binary] \
    django-extensions \
    django-picklefield \
    django-jsoneditor \
    pyyaml \
    python-magic \
    filetype \
    channels-redis \
    django-cors-headers \
    djangorestframework \
    django-filter \
    graphene-django \
    django-channels-graphql-ws \
    awscli \
    boto3

# Install Celery and task queue packages
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    celery \
    redis \
    django-celery-beat \
    django-celery-results

# Install external service API clients
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    stripe \
    simple-salesforce \
    canvasapi \
    zeep

# Install additional Django packages
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    nested-admin \
    django-better-admin-arrayfield \
    django-localflavor \
    django-phonenumber-field \
    django-postgres \
    django-environ \
    whitenoise

# Install Elasticsearch integration
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    django-elasticsearch-dsl \
    elasticsearch

# Install monitoring and observability packages
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install \
    django-prometheus \
    python-json-logger \
    opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-instrumentation-django \
    opentelemetry-instrumentation-psycopg2 \
    opentelemetry-instrumentation-redis \
    opentelemetry-instrumentation-celery \
    opentelemetry-exporter-otlp

# Create app directory
RUN mkdir -p /app

# Set working directory
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Set Python binary path as environment variable
ENV PYTHON_BIN=/opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION}

# Default command (can be overridden in k8s deployment)
CMD ["/bin/sh", "-c", "${PYTHON_BIN} --version"]
