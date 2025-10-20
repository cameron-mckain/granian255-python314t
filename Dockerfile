FROM quay.io/pypa/manylinux2014_x86_64:latest

# Install system development packages
RUN yum install -y \
    python3-devel \
    libxml2-devel \
    libxslt-devel \
    postgresql-devel \
    && yum clean all

# Upgrade pip for Python 3.14t
RUN python3.14t -m pip install --upgrade pip

# Install Django 5.1.5
RUN python3.14t -m pip install django==5.1.5

# Install Granian 2.5.5 (Python 3.14t free-threaded wheel)
RUN python3.14t -m pip install https://files.pythonhosted.org/packages/de/59/32bad6d962ae2b63b30616183d9750b0ff84559099173c1aee6905fff8d2/granian-2.5.5-cp314-cp314t-manylinux_2_17_x86_64.manylinux2014_x86_64.whl

# Install additional Python packages
RUN python3.14t -m pip install \
    lxml \
    requests \
    beautifulsoup4 \
    numpy \
    pandas \
    matplotlib \
    psycopg[binary] \
    django-extensions

# Create app directory
RUN mkdir -p /app

# Set working directory
WORKDIR /app

# Expose port 8000
EXPOSE 8000

# Default command (can be overridden in k8s deployment)
CMD ["python3.14t", "--version"]
