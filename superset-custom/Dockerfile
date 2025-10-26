# Custom Apache Superset Image with Database Drivers
# Based on official Apache Superset image with pre-installed database drivers

FROM apache/superset:latest

# Switch to root to install packages
USER root

# Install system dependencies for database drivers
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pip into the virtual environment using get-pip.py
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    /app/.venv/bin/python get-pip.py && \
    rm get-pip.py

# Install database drivers into the virtual environment
RUN /app/.venv/bin/pip install --no-cache-dir \
    psycopg2-binary==2.9.9 \
    sqlalchemy-utils==0.41.1 \
    clickhouse-driver==0.2.6 \
    clickhouse-sqlalchemy==0.2.4

# Verify installations
RUN /app/.venv/bin/python -c "import psycopg2; print('psycopg2 installed successfully')" && \
    /app/.venv/bin/python -c "import sqlalchemy_utils; print('sqlalchemy-utils installed successfully')" && \
    /app/.venv/bin/python -c "import clickhouse_driver; print('clickhouse-driver installed successfully')"

# Create bootstrap marker to skip bootstrap script
RUN touch /root/bootstrap && echo "Database drivers pre-installed in image" > /root/bootstrap

# Switch back to superset user for runtime
USER superset

# Labels for image metadata
LABEL org.opencontainers.image.title="Superset with Database Drivers"
LABEL org.opencontainers.image.description="Apache Superset with pre-installed PostgreSQL and ClickHouse drivers"
LABEL org.opencontainers.image.source="https://github.com/cameron-mckain/granian255-python314t"
LABEL org.opencontainers.image.version="latest"
