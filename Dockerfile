FROM quay.io/pypa/manylinux_2_28_x86_64:latest

# Install system development packages
RUN yum install -y \
    python3-devel \
    libxml2-devel \
    libxslt-devel \
    postgresql-devel \
    && yum clean all

# Upgrade pip for Python 3.14t
RUN python3.14t -m pip install --upgrade pip

# Install Django 5.2.7
RUN python3.14t -m pip install django==5.2.7

# Install Granian 2.5.5 (Python 3.14t free-threaded wheel)
RUN python3.14t -m pip install granian==2.5.5

# Install additional Python packages
RUN python3.14t -m pip install \
    lxml \
    requests \
    beautifulsoup4 \
    numpy \
    pandas \
    matplotlib \
    psycopg \
    django-extensions

# Create app directory
RUN mkdir -p /app

# Set working directory
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Default command (can be overridden in k8s deployment)
CMD ["python3.14t", "--version"]
