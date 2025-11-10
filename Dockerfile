ARG PYTHON_VERSION=3.14t
ARG PYTHON_PATH=cp314-cp314t

FROM quay.io/pypa/manylinux_2_28_x86_64:latest

ARG PYTHON_VERSION
ARG PYTHON_PATH

# Install system development packages
RUN yum install -y \
    python3-devel \
    libxml2-devel \
    libxslt-devel \
    postgresql-devel \
    file-devel \
    mesa-libGL \
    && yum clean all

# Upgrade pip
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install --upgrade pip

# Install Django 5.2.8
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install django==5.2.8

# Install Granian 2.5.7
RUN /opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION} -m pip install granian==2.5.7

# Install additional Python packages
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
    psycopg \
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
    awscli

# NOTE: opencv-python removed - will be added later from pre-built wheel
# to avoid circular dependency (this image is used to BUILD opencv-python)

# Create app directory
RUN mkdir -p /app

# Set working directory
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Default command (can be overridden in k8s deployment)
# Use full path since we can't reliably create symlinks (may already exist in base image)
ENV PYTHON_BIN=/opt/python/${PYTHON_PATH}/bin/python${PYTHON_VERSION}
CMD ["/bin/sh", "-c", "${PYTHON_BIN} --version"]
