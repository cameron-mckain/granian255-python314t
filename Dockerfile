FROM quay.io/pypa/manylinux_2_28_x86_64:latest

# Install system development packages
RUN yum install -y \
    python3-devel \
    libxml2-devel \
    libxslt-devel \
    postgresql-devel \
    file-devel \
    mesa-libGL \
    && yum clean all

# Upgrade pip for Python 3.14t
RUN python3.14t -m pip install --upgrade pip

# Install Django 5.2.8
RUN python3.14t -m pip install django==5.2.8

# Install Granian 2.5.7 (Python 3.14t free-threaded wheel)
RUN python3.14t -m pip install granian==2.5.7

# Install additional Python packages
RUN python3.14t -m pip install \
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
CMD ["python3.14t", "--version"]
